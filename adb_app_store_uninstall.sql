-- File_name : adb_app_store_uninstall.sql
-- Version   : 1.0
-- Code to Uninstall the app store application from workspace.

--------------------------------------------------------------------------------
-- ORACLE LICENSE
--------------------------------------------------------------------------------

declare
    c_workspace apex_workspaces.workspace%type;
    c_app_id apex_applications.application_id%type;
    c_app_alias apex_applications.alias%type;
    l_workspace_id apex_workspaces.workspace_id%type;
    drop_user_stmt varchar2(1000);
    l_application_id number;

begin
    
    apex_application_install.clear_all;

    l_workspace_id := apex_util.find_security_group_id (p_workspace => 'ADB_APP_STORE');
    apex_application_install.set_workspace_id(l_workspace_id);
    apex_util.set_security_group_id (p_security_group_id => l_workspace_id); 

    select application_id into l_application_id from apex_applications where workspace='ADB_APP_STORE' and application_name='ADB App Store';

    wwv_flow_imp.component_begin (
     p_version_yyyy_mm_dd=>'2022.04.12'
    ,p_release=>'22.1.0'
    ,p_default_workspace_id=>l_workspace_id
    ,p_default_application_id=>l_application_id
    ,p_default_id_offset=>null
    ,p_default_owner=>'ADB_APP_STORE'
    );
    
    wwv_flow_imp.remove_flow(wwv_flow.g_flow_id);
    wwv_flow_imp.component_end;

end;
/

declare 
l_tab_exists number;

BEGIN

    select count(1) into l_tab_exists
    from all_tables
    where owner='ADB_APP_STORE'
    and table_name='APP_UPDATE_CONFIG';

    if l_tab_exists=1 then
        
        execute immediate ('drop table adb_app_store.app_update_config');

    end if;

END;
/

-- Code to Remove the workspace from APEX environment.

declare
l_stmt            CLOB;
l_workspace_cnt   NUMBER;
workspace_name    VARCHAR2(100);

BEGIN
workspace_name :='ADB_APP_STORE';

l_stmt:='SELECT COUNT(1)
         FROM apex_workspaces
         WHERE workspace=:1';

EXECUTE IMMEDIATE l_stmt INTO l_workspace_cnt USING workspace_name;

IF (l_workspace_cnt=1)
THEN
  l_stmt:='begin APEX_INSTANCE_ADMIN.REMOVE_WORKSPACE (
              p_workspace          => :1); end;';

  EXECUTE IMMEDIATE l_stmt USING workspace_name;
  
  COMMIT;
  
END IF;

END;
/
