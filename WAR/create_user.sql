-- suggested user name is WAR_USER
-- please replace XXXXXXX with secure password


CREATE USER WAR_USER identified by XXXXXXXX;

GRANT execute on dbms_workload_repository to WAR_USER;
GRANT execute on dbms_perf to WAR_USER;
GRANT select_catalog_role to WAR_USER;
