--To remove the application entirely run the below statements

BEGIN
APEX_INSTANCE_ADMIN.remove_workspace('APEX$_APP_STORE');
END;
/

drop user APEX$_APP_STORE cascade;
