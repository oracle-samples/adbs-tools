package plugin

import (
	"context"
	"encoding/json"
	"time"
	"strings"
	"strconv"
	"errors"
	"database/sql/driver"
	"reflect"

    go_ora "github.com/sijms/go-ora/v2"
	"github.com/grafana/grafana-plugin-sdk-go/backend"
	"github.com/grafana/grafana-plugin-sdk-go/backend/instancemgmt"
	"github.com/grafana/grafana-plugin-sdk-go/backend/log"
	"github.com/grafana/grafana-plugin-sdk-go/data"
)

// Make sure Datasource implements required interfaces. This is important to do
// since otherwise we will only get a not implemented error response from plugin in
// runtime. In this example datasource instance implements backend.QueryDataHandler,
// backend.CheckHealthHandler interfaces. Plugin should not implement all these
// interfaces- only those which are required for a particular task.
var (
	_ backend.QueryDataHandler      = (*ADBDatasource)(nil)
	_ backend.CheckHealthHandler    = (*ADBDatasource)(nil)
	_ instancemgmt.InstanceDisposer = (*ADBDatasource)(nil)
)


// Contains enteries from Config page in backend
type ADBDatasourceconfig struct {
	user			string
	password		string
	ConnectString   string	`json:"connectstring"`
	urlOptions 		map[string]string 
	host            string
	port 			string
	service			string
}


// Contains connection parameters for go-ora in backend
type ADBDatasource struct{
	host 			string
	portnumber 		int
	servicename 	string
	user 			string
	password 		string
	urlOptions 		map[string]string
}


// To check type of data
func typeof(v interface{}) string {
    return reflect.TypeOf(v).String()
}



// Get the partial type of data of column to use it for conversion later 
func getTypeArray(typ string) string {
	typee := strings.ToLower(typ)

	if strings.Contains(typee, "time") || strings.Contains(typee, "date") { 
		return "time"
	} else if strings.Contains(typee, "decimal") || strings.Contains(typee, "number") || strings.Contains(typee, "int") {
		return "float"
	} else if strings.Contains(typee, "blob") {
		return "blobstring"
	} else {
		return "string"
	}
}

// To set query to work on time span selected in grafana page
func setquery(old_q string , from_time string, to_time string , timezone string) string {
	if strings.Contains(old_q, "$timefilter(") {
		var new_q string = ""
		part1 := strings.Split(old_q, "$timefilter(")
		index_x := strings.Index(part1[1], ")")
		coln_name := strings.TrimSpace(part1[1][:index_x])
		part3 := part1[1][index_x:]
		new_q += part1[0] + coln_name + " BETWEEN TO_TIMESTAMP('"+ from_time + "', 'YYYY-MM-DD HH24:MI:SS.FF') AND TO_TIMESTAMP('" + to_time + "', 'YYYY-MM-DD HH24:MI:SS.FF'" + part3
		return new_q

	} else if strings.Contains(old_q, "$timefilter_tz(") {
		var new_q string = ""
		part1 := strings.Split(old_q, "$timefilter_tz(")
		index_x := strings.Index(part1[1], ")")
		coln_name := strings.TrimSpace(part1[1][:index_x])
		part3 := part1[1][index_x:]
		new_q += part1[0] + coln_name + " BETWEEN TO_TIMESTAMP_TZ('"+ from_time + " " + timezone + "', 'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM') AND TO_TIMESTAMP_TZ('" + to_time + " " + timezone + "', 'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM'" + part3
		return new_q

	} else {
		return old_q

	}
}


// Convert value to grafana dataframe type and return its interface
func toValue(val interface{}, col_type string) interface{} {
    if (val == nil) {
		return nil
    }

	switch t := col_type; t {
	case "blobstring":
		var str string = "Blob"
		var str2 *string = &str
		r_interface := []interface{}{str2}
		return r_interface[0].(*string)
	}

	switch val.(type) {
	case float32:
		var num float64 = float64(val.(float32))
		var num2 *float64 = &num
		r_interface := []interface{}{num2}
		return r_interface[0].(*float64)
	case float64:
		var num float64 = float64(val.(float64))
		var num2 *float64 = &num
		r_interface := []interface{}{num2}
		return r_interface[0].(*float64)	
	case int64:
		var num float64 = float64(val.(int64))
		var num2 *float64 = &num
		r_interface := []interface{}{num2}
		return r_interface[0].(*float64)
	case int32:
		var num float64 = float64(val.(int32))
		var num2 *float64 = &num
		r_interface := []interface{}{num2}
		return r_interface[0].(*float64)
	case string:
		var str string = string(val.(string))
		var str2 *string = &str
		r_interface := []interface{}{str2}
		return r_interface[0].(*string)
	case time.Time:
		var tt time.Time = time.Time(val.(time.Time))
		var tt2 *time.Time = &tt
		r_interface := []interface{}{tt2}
		return r_interface[0].(*time.Time)
	case go_ora.TimeStamp:
		var tt time.Time = time.Time(val.(go_ora.TimeStamp))
		var tt2 *time.Time = &tt
		r_interface := []interface{}{tt2}
		return r_interface[0].(*time.Time)
	default:
		r, err := json.Marshal(val)
		if (err != nil) {
			log.DefaultLogger.Info("Marsheling failed ", "err", err)
		}
		var str string = string(r)
		var str2 *string = &str
		r_interface := []interface{}{str2}
		return r_interface[0].(*string)
	}

}


// NewADBDatasource creates a new datasource instance.
func NewADBDatasource(setting backend.DataSourceInstanceSettings) (instancemgmt.Instance, error) {
	
	var ds ADBDatasourceconfig
	log.DefaultLogger.Info("Going to create connection")
	var secureData = setting.DecryptedSecureJSONData
    ds.password = secureData["password"]
    ds.user = secureData["user"]

	if (len(ds.user) ==0 ){
		log.DefaultLogger.Error("User is not provided")
		err1 := errors.New("Please provide username")
		return nil, err1	
	}

	if (len(ds.password) ==0 ){
		log.DefaultLogger.Error("Password is not provided")
		err1 := errors.New("Please provide password")
		return nil, err1	
	}

    type editModel struct {
        ConnectString string `json:"connectionstring"`
    }

	var c_str editModel
    err := json.Unmarshal(setting.JSONData, &c_str)
    if err != nil {
        log.DefaultLogger.Warn("error marshalling Connectstring", "err", err)
        return nil, err
    }

	ds.ConnectString = c_str.ConnectString

	//Set ssl options
	if (len(ds.ConnectString) != 0) {

		ds.urlOptions = map[string] string{
			"SSL Verify": "False",
			"SSL": "enable",
		}
	

		data := ds.ConnectString
		// Check ConnectionString correct format
		if strings.Count(data, ":") !=2 {
			// log the error and send it to grafana UI too
			log.DefaultLogger.Error("Please provide connectionstring in format hostname:port:servicename")
			err1 := errors.New("Please provide connectionstring in format hostname:port:servicename")
			return nil, err1
		}
		
		// Get host, port an service from connection string 
		ds.host = strings.ReplaceAll(strings.Split(data, ":")[0], " ", "")
		ds.port = strings.ReplaceAll(strings.Split(data, ":")[1], " ", "") 
		ds.service = strings.ReplaceAll(strings.Split(data, ":")[2], " ", "")
			
	} else
	{
		log.DefaultLogger.Error("Please provide connectionstring in format hostname:port:servicename")
		err1 := errors.New("Please provide connectionstring in format hostname:port:servicename")
		return nil, err1				
	}

	portnumber, err := strconv.Atoi(ds.port)
 
	return &ADBDatasource{
		host: ds.host,
		portnumber: portnumber,
		servicename: ds.service,
		user: ds.user,
		password: ds.password,
		urlOptions: ds.urlOptions,
	}, nil
}	

// Dispose here tells plugin SDK that plugin wants to clean up resources when a new instance
// created. As soon as datasource settings change detected by SDK old datasource instance will
// be disposed and a new one will be created using NewSampleDatasource factory function.
func (d *ADBDatasource) Dispose() {
	// Clean up datasource instance resources.
	log.DefaultLogger.Info("Disposing the old Datasource Config")
	if d != nil {
			d = nil
	}
}

// QueryData handles multiple queries and returns multiple responses.
// req contains the queries []DataQuery (where each query contains RefID as a unique identifier).
// The QueryDataResponse contains a map of RefID to the response for each query, and each response
// contains Frames ([]*Frame).
func (d *ADBDatasource) QueryData(ctx context.Context, req *backend.QueryDataRequest) (*backend.QueryDataResponse, error) {
	log.DefaultLogger.Info("QueryData called", "request", req)
	// create response struct
	response := backend.NewQueryDataResponse()

	if(d==nil){
		log.DefaultLogger.Info("There is no datasouce")
		for _, q := range req.Queries {
			err_res := backend.DataResponse{}
			err_res.Error = errors.New("There is no datasouce, please check config")
			response.Responses[q.RefID] = err_res		
		}
		return response, nil
	}

	log.DefaultLogger.Info("Trying to create connection")
	connectionString := go_ora.BuildUrl(d.host, d.portnumber, d.servicename, d.user, d.password, d.urlOptions)
	//log.DefaultLogger.Info("Connecting with url", "url", connectionString)
	conn, err := go_ora.NewConnection(connectionString)
	if err != nil {
		log.DefaultLogger.Info("Can't create connenection", err)
		for _, q := range req.Queries {
			err_res := backend.DataResponse{}
			err_res.Error = errors.New("Please check config, Can't create connection "+ err.Error())
			response.Responses[q.RefID] = err_res		
		}
		return response, nil

	}
	
	err = conn.Open()
	if err != nil {
		log.DefaultLogger.Info("Can't open connection: ", err)
		for _, q := range req.Queries {
			err_res := backend.DataResponse{}
			err_res.Error = errors.New("Please check config, Can't open connection: "+err.Error())
			response.Responses[q.RefID] = err_res		
		}
		return response, nil
	}

	log.DefaultLogger.Info("Connection is open")

	for _, q := range req.Queries {

		res := d.query(ctx, req.PluginContext, q, conn)
		response.Responses[q.RefID] = res
	
	}

	log.DefaultLogger.Info("Closing the connection")
	conn.Close()

	return response, nil
}

// Set querymodel to get the query details, we can add more objects later if it needed
type queryModel struct{
	QueryText string `json:"queryText"`
}

func (d *ADBDatasource) query(_ context.Context, pCtx backend.PluginContext, query backend.DataQuery, conn *go_ora.Connection ) backend.DataResponse {
	response := backend.DataResponse{}

	// Unmarshal the JSON into our queryModel.
	var qm queryModel

	response.Error = json.Unmarshal(query.JSON, &qm)
	if response.Error != nil {
		return response
	}

	// create data frame response.
	frame := data.NewFrame("response")
    if (len(qm.QueryText)==0){ 
		//return empty response
		return response
	}

	// Get from time , to time and timezone for query from grafana
	fromMs := query.TimeRange.From.UnixNano() / int64(time.Millisecond)
	toMs := query.TimeRange.To.UnixNano() / int64(time.Millisecond)
	var start string = time.Unix(fromMs/1000, (fromMs%1000)*1000000).UTC().String()
	var end string = time.Unix(toMs/1000, (toMs%1000)*1000000).UTC().String()
	var starttime string = strings.Split(start, " ")[0] + " " + strings.Split(start, " ")[1]
	var endtime string = strings.Split(end, " ")[0] + " " + strings.Split(end, " ")[1]
	var timezone string = strings.Split(end, " ")[2]

	// Set the query with timespan filter
	var ADBquery string = setquery(strings.TrimSpace(qm.QueryText), starttime, endtime, timezone)
	// go-ora needs query without ; at end
	if strings.HasSuffix(ADBquery, ";") {
        ADBquery = ADBquery[:len(ADBquery)-1]
    }

	// handle query on the conn
    stmt := go_ora.NewStmt(ADBquery, conn)
	defer stmt.Close()

	rows, err := stmt.Query(nil)
	if err != nil {
		log.DefaultLogger.Info("Getting error while query and err is ",err)
		response.Error = err
		return response
	}
	defer rows.Close()

	columns := rows.Columns()
	var tt int
	typecolumn := make([]string, len(columns))

	// set the dataframe based on partial info provided from go-ora about datatypes of columns
	// and store it in typecolumn for conversion of the data in columns. 
	for tt=0; tt<len(columns); tt++ {

		if prop, ok := rows.(driver.RowsColumnTypeDatabaseTypeName); ok {
			ctrss := prop.ColumnTypeDatabaseTypeName(tt)
			
			typet := getTypeArray(ctrss)
			typecolumn[tt] = typet

			if typet == "time" {
				frame.Fields = append(frame.Fields,
					data.NewField(columns[tt], nil, []*time.Time{}),
				)	
			} else if typet == "float" {
				frame.Fields = append(frame.Fields,
					data.NewField(columns[tt], nil, []*float64{}),			
				)	
			} else {
				frame.Fields = append(frame.Fields,
					data.NewField(columns[tt], nil, []*string{}),			
				)	
			}
		}		
	}

	// Get the data by rows and convert it to the dataframe type associated with its columns before addding
	// to grafana 
	values := make([]driver.Value, len(columns))
	for {
		err = rows.Next(values)
		if err != nil {
			break
		}
		vals := make([]interface{}, len(columns))
		for i, c := range values {
			
			tt := toValue(c, typecolumn[i])
            vals[i] = tt
			
        }
        frame.AppendRow(vals...)
	}	
	// add the frames to the response.
	response.Frames = append(response.Frames, frame)

	return response
}

// CheckHealth handles health checks sent from Grafana to the plugin.
// The main use case for these health checks is the test button on the
// datasource configuration page which allows users to verify that
// a datasource is working as expected.
func (d *ADBDatasource) CheckHealth(ctx context.Context, req *backend.CheckHealthRequest) (*backend.CheckHealthResult, error) {
	log.DefaultLogger.Info("CheckHealth called", "request", req)
	// Do a checkhealth of ADB by creating a connection and pining it
	if d != nil {
		log.DefaultLogger.Info("Checking datasource health")
		connectionString := go_ora.BuildUrl(d.host, d.portnumber, d.servicename, d.user, d.password, d.urlOptions)
		conn, err := go_ora.NewConnection(connectionString)
		if err != nil {
			log.DefaultLogger.Info("Can't create connenection", err)
			return &backend.CheckHealthResult{
				Status:  backend.HealthStatusError,
				Message: "Healthcheck to Datasource failed" + err.Error() ,
			}, nil

		}

		err = conn.Open()
		if err != nil {
			log.DefaultLogger.Info("Can't open connection: ", err)
			return &backend.CheckHealthResult{
				Status:  backend.HealthStatusError,
				Message: "Healthcheck to Datasource failed" + err.Error() ,
			}, nil
		}
		log.DefaultLogger.Info("Connection is open")
		defer conn.Close()

		err1 := conn.Ping(ctx)
		if err1 != nil {
			log.DefaultLogger.Info("DB ping does not work")
			return &backend.CheckHealthResult{
				Status:  backend.HealthStatusError,
				Message: "Healthcheck to Datasource failed" + err.Error() ,
			}, nil
		} else {
			return &backend.CheckHealthResult{
				Status:  backend.HealthStatusOk,
				Message: "Datasoure is working",
			}, nil

		}
	}
	
	return &backend.CheckHealthResult{
		Status:  backend.HealthStatusError,
		Message: "Datasouce info is not complete to connect",
	}, nil
	
}
