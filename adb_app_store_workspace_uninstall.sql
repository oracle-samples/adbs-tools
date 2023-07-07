-- File_name : adb_app_store_workspace_uninstall.sql
-- Version   : 1.0
-- Code to Uninstall the ADB app store APEX Workspace.

--------------------------------------------------------------------------------
-- ORACLE LICENSE
--------------------------------------------------------------------------------

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
