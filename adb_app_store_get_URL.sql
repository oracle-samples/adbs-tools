-- File_name : adb_app_store_get_URL.sql
-- Version   : 1.0
-- Code to get the ADB app store application URL.

--------------------------------------------------------------------------------
-- ORACLE LICENSE
--------------------------------------------------------------------------------

set linesize 400
col app_login_url for a120
SELECT 'https://'||LOWER(REPLACE(name,'_','-'))||'.adb.'||
JSON_VALUE(cloud_identity,'$.REGION')||'.oraclecloudapps.com/ords/r/adb_app_store/adb_app_store'
AS app_login_url
FROM sys.v_$pdbs;
