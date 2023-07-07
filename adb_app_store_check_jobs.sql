-- File_name : adb_app_store_check_jobs.sql
-- Version   : 1.0
-- Code to check the ADB cost usage application OCI data collections.

--------------------------------------------------------------------------------
-- ORACLE LICENSE
--------------------------------------------------------------------------------

set linesize 200
col owner for a20
col job_name for a40
select log_id, log_date, owner, job_name
from all_scheduler_job_run_details
where owner='ADB$_COST_USAGE'
order by log_date desc
/
