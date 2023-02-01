

--Create a new Database user and provide necessary grants. This user will be used to login to App store application.

begin

create user APEX$_APP_STORE no authentication;
grant connect,resource to APEX$_APP_STORE with ADMIN option;

grant create user to APEX$_APP_STORE;
grant drop user to APEX$_APP_STORE;

grant create session, create table, create sequence, create procedure , create view to APEX$_APP_STORE with ADMIN OPTION;
grant create any table to APEX$_APP_STORE;
grant create any index to APEX$_APP_STORE;
grant create any procedure to APEX$_APP_STORE;
grant create any materialized view to APEX$_APP_STORE;
grant create any job to APEX$_APP_STORE with ADMIN option;
grant create materialized view to APEX$_APP_STORE with ADMIN option;

grant insert any table to APEX$_APP_STORE;
grant manage scheduler to APEX$_APP_STORE with ADMIN option;
grant apex_administrator_role to APEX$_APP_STORE;
grant alter any materialized view to APEX$_APP_STORE;
grant select on V$PDBS to APEX$_APP_STORE with grant option;
grant read,write on directory DATA_PUMP_DIR to APEX$_APP_STORE with grant option;

grant execute any procedure to APEX$_APP_STORE;
grant execute on DBMS_CLOUD_ADMIN to APEX$_APP_STORE;
grant execute on DBMS_SCHEDULER to APEX$_APP_STORE with grant option;    
grant execute on DBMS_CLOUD_NOTIFICATION to APEX$_APP_STORE with grant option;
grant execute on dbms_workload_repository to APEX$_APP_STORE with grant option;
grant execute on dbms_perf to APEX$_APP_STORE with grant option;
grant select_catalog_role to APEX$_APP_STORE with ADMIN option;

grant drop any table to APEX$_APP_STORE;
grant drop any procedure to APEX$_APP_STORE;

exec DBMS_CLOUD_ADMIN.ENABLE_RESOURCE_PRINCIPAL(USERNAME => 'APEX$_APP_STORE',grant_option=>true);

end;
/

--Tablespace grants to new user.

create or replace procedure grant_quota ( user_name in varchar2, tbsp_name in varchar2) as
begin

If tbsp_name not in ('SYSAUX','SYSTEM') then
execute immediate 'alter user '||user_name||' quota unlimited on '|| tbsp_name;

end if;
end;
/


begin

grant execute on grant_quota to APEX$_APP_STORE;
exec grant_quota('APEX$_APP_STORE','DATA');

end;
/


--Below grants are required for OCI_COST_USAGE Application

begin

grant execute on DBMS_CLOUD to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_REPO to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_MN_MONITORING to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CR_BLOCKSTORAGE to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CR_COMPUTE to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DB_DATABASE to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_FS_FILE_STORAGE to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_LB_LOAD_BALANCER to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_OBS_OBJECT_STORAGE to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_OBS_OBJECT_STORAGE_GET_BUCKET_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_OBS_OBJECT_STORAGE_GET_BUCKET_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_OBJECT_STORAGE_BUCKET_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DB_DATABASE_GET_AUTONOMOUS_DATABASE_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DATABASE_AUTONOMOUS_DATABASE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DB_DATABASE_GET_CLOUD_VM_CLUSTER_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DATABASE_CLOUD_VM_CLUSTER_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_LB_LOAD_BALANCER_GET_LOAD_BALANCER_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_LOAD_BALANCER_LOAD_BALANCER_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CR_COMPUTE_GET_INSTANCE_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CORE_INSTANCE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_FS_FILE_STORAGE_GET_FILE_SYSTEM_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_FILE_STORAGE_FILE_SYSTEM_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CR_BLOCKSTORAGE_GET_VOLUME_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CORE_VOLUME_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CR_BLOCKSTORAGE_GET_VOLUME_BACKUP_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CORE_VOLUME_BACKUP_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CR_BLOCKSTORAGE_GET_BOOT_VOLUME_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CORE_BOOT_VOLUME_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CR_BLOCKSTORAGE_GET_BOOT_VOLUME_BACKUP_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_CORE_BOOT_VOLUME_BACKUP_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_ID_IDENTITY_GET_TENANCY_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_IDENTITY_TENANCY_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_ID_IDENTITY to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_MONITORING_SUMMARIZE_METRICS_DATA_DETAILS_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_MN_MONITORING_SUMMARIZE_METRICS_DATA_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_MONITORING_METRIC_DATA_TBL to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_MONITORING_AGGREGATED_DATAPOINT_TBL to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DB_DATABASE_GET_CLOUD_EXADATA_INFRASTRUCTURE_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DATABASE_CLOUD_EXADATA_INFRASTRUCTURE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DB_DATABASE_GET_CLOUD_VM_CLUSTER_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DATABASE_CLOUD_VM_CLUSTER_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DB_DATABASE_GET_DB_SYSTEM_RESPONSE_T to APEX$_APP_STORE with grant option;
grant execute on DBMS_CLOUD_OCI_DATABASE_DB_SYSTEM_T to APEX$_APP_STORE with grant option;

end;
/

BEGIN

    APEX_INSTANCE_ADMIN.ADD_WORKSPACE (
        p_workspace_id       => null,
        p_workspace          => 'APEX$_APP_STORE',
        p_primary_schema     => 'APEX$_APP_STORE',
        p_additional_schemas => null);
        
    apex_instance_admin.enable_workspace(p_workspace => 'APEX$_APP_STORE');
    
    commit;
    
END;
/

--New user for Apex develpment environment.Set a new password ("<Set your password>") in below code & execute.

declare
l_workspace_id number;
l_group_id     number;
begin

l_workspace_id := apex_util.find_security_group_id('APEX$_APP_STORE');

apex_util.set_security_group_id(l_workspace_id);
wwv_flow_api.set_security_group_id(l_workspace_id);

l_group_id := apex_util.get_group_id('Admin');
    
    APEX_UTIL.CREATE_USER(
    p_user_name                     => 'APEX$_APP_STORE',
    p_first_name                    => 'APP_STORE_USER',
    p_description                   => 'Login user for APEX$_APP_STORE workspace',
    p_web_password                  => <Set your new password>,
    p_developer_privs               => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
    p_default_schema                => 'APEX$_APP_STORE',
    p_change_password_on_first_use  => 'N');
    
 commit;
 
end;
/  

--Change the password for the apex$_app_store user by logging in as admin.

ALTER USER APEX$_APP_STORE IDENTIFIED BY <Set your new password>;

--Run the below script to install the application

declare
    c_workspace apex_workspaces.workspace%type;
    c_app_id apex_applications.application_id%type;
    c_app_alias apex_applications.alias%type;
    l_workspace_id apex_workspaces.workspace_id%type;
begin
    apex_application_install.clear_all;

    select workspace_id
    into l_workspace_id
    from apex_workspaces
    where workspace = 'APEX$_APP_STORE';

    apex_application_install.set_workspace_id(l_workspace_id);
    apex_application_install.set_application_alias('APEX$_APP_STORE');
    apex_application_install.generate_offset;

    dbms_cloud_repo.install_sql(
            to_clob(
            dbms_cloud.get_object(
            null,'https://objectstorage.eu-frankfurt-1.oraclecloud.com/n/dwcsdev/b/app_store_metadata/o/apex_app_store/apex_app_store_ddl.sql'
            )),stop_on_error => TRUE
    );

    dbms_cloud_repo.install_sql(
            to_clob(
            dbms_cloud.get_object(
            null,'https://objectstorage.eu-frankfurt-1.oraclecloud.com/n/dwcsdev/b/app_store_metadata/o/backup/apex_app_store_manual_inst.sql'
            )),stop_on_error => TRUE
    );

end;
/

