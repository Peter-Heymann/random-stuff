## Description

This scenario addresses the monitoring services you can use and describes a dataflow model for use with multiple data sources. When it comes to monitoring, many tools and services work with Azure deployments. In this scenario, we choose readily available services precisely because they are easy to consume. 

## Architecture components

1. Resource group 
2. Virtual Network 
3. Subnets
4. Azure Monitor
5. Linux Web app
6. App insight
7. Storage Account
6. Mariadb Server
7. Mariadb Database

Azure App Service is a PaaS service for building and hosting apps in managed virtual machines. The underlying compute infrastructures on which your apps run is managed for you. App Service provides monitoring of resource usage quotas and app metrics, logging of diagnostic information, and alerts based on metrics. Even better, you can use Application Insights to create availability tests for testing your application from different regions.
Application Insights is an extensible Application Performance Management (APM) service for developers and supports multiple platforms. It monitors the application, detects application anomalies such as poor performance and failures, and sends telemetry to the Azure portal. Application Insights can also be used for logging, distributed tracing, and custom application metrics.
Azure Monitor provides base-level infrastructure metrics and logs for most services in Azure. You can interact with the metrics in several ways, including charting them in Azure portal, accessing them through the REST API, or querying them using PowerShell or CLI. Azure Monitor also offers its data directly into Log Analytics and other services, where you can query and combine it with data from other sources on premises or in the cloud.
Log Analytics helps correlate the usage and performance data collected by Application Insights with configuration and performance data across the Azure resources that support the app. This scenario uses the Azure Log Analytics agent to push SQL Server audit logs into Log Analytics. You can write queries and view data in the Log Analytics blade of the Azure portal.
Scenario details
Azure platform as a service (PaaS) offerings manage compute resources for you and affect how you monitor deployments. Azure includes multiple monitoring services, each of which performs a specific role. Together, these services deliver a comprehensive solution for collecting, analyzing, and acting on telemetry from your applications and the Azure resources they consume.

This scenario addresses the monitoring services you can use and describes a dataflow model for use with multiple data sources. When it comes to monitoring, many tools and services work with Azure deployments. In this scenario, we choose readily available services precisely because they are easy to consume. Other monitoring options are discussed later in this article.

## Requirements 

| Name | Configuration |
| --- | --- |
| Terraform | all versions |
| Provider  | Azure |
| Provider version  | >= 3.2 |
| Access | Contributor access |

## How to use the architecture

To use this architecture , clone it within your project and change the following components:

Change the configuration of the cloud provider. In order to use the architecture you need to have a kubernetes cluster in place and change the resource group and name of the kubernetes cluster inside the configuration . Then change the variables: 

| Variable | Description |
| --- | --- |
|prefix| Application name |
| db_admin | MariaDB Database Admin Username |
| db_pass | MariaDB Database Admin Password |
| snet_database_prefix | Database Subnet Prefix |
| snet_webapp_prefix | Web App Subnet Prefix |
| vnet_main_addrspace | Virtual Network Address Space |
