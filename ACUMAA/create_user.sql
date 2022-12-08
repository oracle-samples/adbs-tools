-- suggested user name is ADBS_COST_USAGE
-- please replace XXXXXXX with secure password

create user ADBS_COST_USAGE identified by XXXXXXX;
 
GRANT CONNECT TO adbs_cost_usage;
GRANT CONNECT, RESOURCE TO adbs_cost_usage;
ALTER USER adbs_cost_usage quota unlimited on DATA;
EXEC DBMS_CLOUD_ADMIN.ENABLE_RESOURCE_PRINCIPAL(username => 'adbs_cost_usage');
