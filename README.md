# adbs-tools

`adbs-tools` is the repository for Oracle supported Autonomous Database Serverless (ADB-S) tools and applications. 
These tools are intended to enhance and facilitate end-user experience in OCI and ADB-S.

## The ADB App Store
The ADB App Store is an application launchpad for Oracle supported applications. Using the ADB App Store, tenants can install and manage the life cycle of these applications. Currently, the available applcations which can be deployed using the ADB App Store include:

    ADB Cost-Usage Management Analytics application - Monitor and manage OCI resource consumption and cost
    Workload Analytics & Reports (WAR) application  - Data analysis and visualization tool for Automatic Workload Repository
    Visual Data Studio                              - Visualization tool for analytics data

## ADB App Store Installation <a name='installation'></a>
Oracle provides the following supported scripts:

    adb_app_store_install.sql                      - ADB App Store installation script
    adb_app_store_get_URL.sql                      - ADB App Store get application URL
    adb_app_store_check_jobs.sql                   - Check OCI Cost & Usage application scheduled jobs
    adb_app_store_uninstall.sql                    - ADB App Store uninstall script
    adb_app_store_workspace_uninstall.sql          - ADB App Store APEX workspace uninstall script

To install the ADB App Store, download the adb_app_store_install.sql and execute as the database ADMIN in your ADB-S database. To identify the application URL execute adb_app_store_get_URL.sql

### ADB App Store Installation Pre-requisites
The ADB App Store leverages a new default database user "ADB_APP_STORE" which exists in all Autonomous Database Serverless (ADBS) databases. The ADB_APP_STORE user has the necessary privileges to install other Oracle supplied ADB-S applications. This user account needs to be unlocked and the password reset:

    alter user ADB_APP_STORE account unlock;
    alter user ADB_APP_STORE identified by <new password>;

### ADB App Store Supported Application Installation
Once the ADB App Store is successfully installed, access the URL returned from the adb_app_store_get_URL.sql. Use the ADB_APP_STORE user credentials with the password you defined as described in the Pre-requisites above. The ADB App Store should return this page:

![image](https://github.com/oracle-samples/adbs-tools/assets/8619317/6a643ae0-ff93-4736-8123-fa4224aa7425)
Clicking on any of the ADB App Cards will give you a description of the application with screen shots, installation instructions, application pre-requisites and the INSTALL button. For example, clicking on the OCI Cost & Usage Analytics ADB App card returns:


![image](https://github.com/oracle-samples/adbs-tools/assets/8619317/361783aa-0056-43c6-8536-4793804050fb)





## Contributing  <a name='contributing'></a>

This project is not accepting contributions at this time

## Security <a name='security'></a>
Please consult the [security guide](https://github.com/oracle-samples/adbs-tools/SECURITY.md) for our responsible security vulnerability disclosure process.

## License <a name='license'></a>
adbs-tools is licensed under Universal Permissive License (UPL) which you can find [here](https://github.com/oracle-samples/adbs-tools/LICENSE.txt)
