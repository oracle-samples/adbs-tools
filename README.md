# adbs-tools TEST BRANCH

`adbs-tools` is the repository for Oracle supported Autonomous Database Serverless (ADB-S) tools and applications. 
These tools are intended to enhance and facilitate end-user experience in OCI and ADB-S.

## The ADB App Store
The ADB App Store is an application launchpad for Oracle supported applications. Using the ADB App Store, tenants can install and manage the life cycle of these applications. Currently, the available applcations which can be deployed using the ADB App Store include:

    ADB Cost-Usage Management Analytics application - Monitor and manage OCI resource consumption and cost
    Workload Analytics & Reports (WAR) application  - Data analysis and visualization tool for Automatic Workload Repository
    Visual Data Studio                              - Visualization tool for analytics data

## Installation
Oracle provides the following supported scripts:

    adb_app_store_install.sql                      - ADB App Store installation script
    adb_app_store_get_URL.sql                      - ADB App Store get application URL
    adb_app_store_check_jobs.sql                   - Check OCI Cost & Usage application scheduled jobs
    adb_app_store_uninstall.sql                    - ADB App Store uninstall script
    adb_app_store_workspace_uninstall.sql          - ADB App Store APEX workspace uninstall script

To install the ADB App Store, download the adb_app_store_install.sql and execute as the database ADMIN in your ADB-S database. To identify the application URL execute adb_app_store_get_URL.sql

### ADB App Store Installation Pre-requisites
The ADB App Store leverages a new default database user "ADB_APP_STORE" which exists in all Autonomous Database Serverless (ADB-S) databases. The ADB_APP_STORE user has the necessary privileges to install other Oracle supplied ADB-S applications. This user account needs to be unlocked and the password reset:

    alter user ADB_APP_STORE account unlock;
    alter user ADB_APP_STORE identified by <new password>;

### ADB App Store Supported Application Installation
Once the ADB App Store installation SQL successfully executes and the application is installed, access the URL returned from the adb_app_store_get_URL.sql. Use the ADB_APP_STORE user credentials with the password you defined as described in the Pre-requisites above. The ADB App Store should return this page:

![image](https://github.com/oracle-samples/adbs-tools/assets/8619317/6a643ae0-ff93-4736-8123-fa4224aa7425)
Clicking on any of the ADB App Cards will give you a description of the application with screen shots, installation instructions, application pre-requisites and the INSTALL button. For example, clicking on the OCI Cost & Usage Analytics ADB App card returns:


![image](https://github.com/oracle-samples/adbs-tools/assets/8619317/361783aa-0056-43c6-8536-4793804050fb)

### Supported SQL Clients
SQL*Plus, 
SQL Developer, 
SQLcl, 
SQL Developer Web

In SQL*Plus, SQL Developer and SQLcl execute:

    set define off;
    @<local_file_path>/adb_app_store_installation.sql
#### NOTE: 
In the Oracle SQL Developer Web client we can't use "@" symbol to run the sql file. Instead, open a new worksheet and paste the contents of the downloaded file. Click on "Run Script" to install the app.

![image](https://github.com/oracle-samples/adbs-tools/assets/8619317/b367baba-1a6f-4c3f-86b1-d280bad35777)

## Contributing

This project is not accepting external contributions at this time. For bugs or enhancement requests, please file a GitHub issue unless it’s security related. When filing a bug remember that the better written the bug is, the more likely it is to be fixed. If you think you’ve found a security vulnerability, do not raise a GitHub issue and follow the instructions in our [security policy](./SECURITY.md).

## Security

Please consult the [security guide](./SECURITY.md) for our responsible security vulnerability disclosure process

## License

Copyright (c) 2022, 2023 year Oracle and/or its affiliates.

Released under the Universal Permissive License v1.0 as shown at
<https://oss.oracle.com/licenses/upl/>.
