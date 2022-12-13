/*
** ADBS Cost-Usage Management Analytics Application (WAR) version 1.0.
**
** Copyright (c) 2022 Oracle Corp
**
** The Universal Permissive License (UPL), Version 1.0
**
** Subject to the condition set forth below, permission is hereby granted to any
** person obtaining a copy of this software, associated documentation and/or data
** (collectively the "Software"), free of charge and under any and all copyright
** rights in the Software, and any and all patent rights owned or freely
** licensable by each licensor hereunder covering either (i) the unmodified
** Software as contributed to or provided by such licensor, or (ii) the Larger
** Works (as defined below), to deal in both
** 
** (a) the Software, and
** (b) any piece of software and/or hardware listed in the lrgrwrks.txt file if
** one is included with the Software (each a "Larger Work" to which the Software
** is contributed by such licensors),
** 
** without restriction, including without limitation the rights to copy, create
** derivative works of, display, perform, and distribute the Software and make,
** use, sell, offer for sale, import, export, have made, and have sold the
** Software and the Larger Work(s), and to sublicense the foregoing rights on
** either these or other terms.
** 
** This license is subject to the following condition:
** The above copyright notice and either this complete permission notice or at
** a minimum a reference to the UPL must be included in all copies or
** substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
** SOFTWARE.
*/

GRANT EXECUTE ON dbms_cloud_oci_mn_monitoring to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_cr_blockstorage to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_cr_compute to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_db_database to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_fs_file_storage to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_lb_load_balancer to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_obs_object_storage to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_obs_object_storage_get_bucket_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_obs_object_storage_get_bucket_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_object_storage_bucket_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_db_database_get_autonomous_database_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_database_autonomous_database_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_db_database_get_cloud_vm_cluster_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_database_cloud_vm_cluster_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_lb_load_balancer_get_load_balancer_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_load_balancer_load_balancer_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_cr_compute_get_instance_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_core_instance_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_fs_file_storage_get_file_system_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_file_storage_file_system_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_cr_blockstorage_get_volume_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_core_volume_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_cr_blockstorage_get_volume_backup_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_core_volume_backup_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_cr_blockstorage_get_boot_volume_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_core_boot_volume_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_cr_blockstorage_get_boot_volume_backup_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_core_boot_volume_backup_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_id_identity_get_tenancy_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_identity_tenancy_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_id_identity to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_monitoring_summarize_metrics_data_details_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_mn_monitoring_summarize_metrics_data_response_t to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_monitoring_metric_data_tbl to adbs_cost_usage;
GRANT EXECUTE ON dbms_cloud_oci_monitoring_aggregated_datapoint_tbl to adbs_cost_usage;
grant execute on dbms_cloud_oci_db_database_get_cloud_exadata_infrastructure_response_t to adbs_cost_usage;
grant execute on dbms_cloud_oci_database_cloud_exadata_infrastructure_t to adbs_cost_usage;
grant execute on dbms_cloud_oci_db_database_get_cloud_vm_cluster_response_t to adbs_cost_usage;
grant execute on dbms_cloud_oci_database_cloud_vm_cluster_t to adbs_cost_usage;
grant execute on dbms_cloud_oci_db_database_get_db_system_response_t to adbs_cost_usage;
grant execute on dbms_cloud_oci_database_db_system_t to adbs_cost_usage;
GRANT SELECT ON v$pdbs to adbs_cost_usage;
grant create any job to adbs_cost_usage;
grant execute on DBMS_SCHEDULER to adbs_cost_usage;
grant manage scheduler to adbs_cost_usage;
grant create materialized view to adbs_cost_usage;
grant read,write on directory DATA_PUMP_DIR to adbs_cost_usage;
grant execute on dbms_cloud_notification to adbs_cost_usage;
