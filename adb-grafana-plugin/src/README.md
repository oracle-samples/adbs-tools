# About Autonomous Database plugin for Grafana

## Introduction
The plugin connects to Oracle Autonomous Database and make queries to it and display them on Grafana.

It is a datasource backend plugin which requires username, password and basic connection string to connect to Oracle ADB.

It can query for timeseries and Non-timeseries data. 

The Plugin is compatible with grafana version >=9.1.2.


## Installation
First Download/clone the plugin complete code as it also contains binaries in dist and let's say the path of downloaded plugin folder is $plug_path. 

### In Docker
Use Docker to load the plugin with grafana server in it with this command.

    docker run -d -p 3000:3000 -v $plug_path:/var/lib/grafana/plugins -e "GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS=oracle-adb-datasource" --name=<container_name> grafana/grafana:9.2.4

Restart the container with 

    docker restart <container-name>

### Install manually on mac or linux
Add the plugin folder from $plug_path to grafana plugin folder (/usr/local/var/lib/grafana/plugins) and set allow_loading_unsigned_plugins = oracle-adb-datasource in config file of it (mainly in default.ini) and restart the grafana server after that. 

### Install from grafana community
The steps for this will be added once it is approved.


## How to Use

* Go to Datasources in setting in grafana page and add datasource. Scroll down and select `Autonomous Database`. 


* In the config page, add `username` and `password` of the user of ADB and add Connection String in `hostname:port:servicename` format.

* Change the name of Datasource to your choice. 

* Click on `Save&Test` to test connectivity to the ADB with the configuration you added. It prompts `Datasoure is working` message if the connection is reachable.


*   ![Config page](https://github.com/oracle-samples/adbs-tools/raw/main/adb-grafana-plugin/src/img/config.png)



* On Query Page Add the configured Datasource. 

* Provide pl/sql query in the `Query` box for the ADB connected to get the data out of it after clicking `RunQuery` button . 

* For timeseries data you can use `$timefilter(timecolumname)` for  timestamp or date type data to query the data for a period of timespan selected in grafana-page.

*   ![Query 1](https://github.com/oracle-samples/adbs-tools/raw/main/adb-grafana-plugin/src/img/query1.png)

* You can add multiple queries in the same panel.

* You can use `$timefilter_tz(timecolumnname)` for timestamp with time zone datatype for same purpose. 

*   ![Query 3](https://github.com/oracle-samples/adbs-tools/raw/main/adb-grafana-plugin/src/img/query3.png)

* You can query for `non-timeseries` data too to show it on table.

*   ![Query 2](https://github.com/oracle-samples/adbs-tools/raw/main/adb-grafana-plugin/src/img/query2.png)

* Save the Panel to your Dashboard. 



