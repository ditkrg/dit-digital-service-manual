# Environment Variables for Micro-Service Applications

This document provides a brief description of the environment variables that are used by the micro-service applications developed by the Department of Information & Technology (DIT). These variables are used to configure various aspects of the applications, such as database connections, cloud storage access, message queue settings, etc. The environment variables follow a standard naming convention that consists of two parts: the prefix and the suffix. The prefix indicates the component or service that the variable belongs to, and the suffix indicates the specific parameter or attribute that the variable represents. For example, `DATABASE__HOST` is an environment variable that specifies the host name of the database server for the application.

The following table lists the environment variables that are common to all DIT micro-service applications, along with their descriptions.

| Environment Variable                               | Description                                                                    |
| :------------------------------------------------- | :----------------------------------------------------------------------------- |
| DATABASE\_\_HOST                                   | The host name or IP address of the database server                             |
| DATABASE\_\_USERNAME                               | The username for accessing the database                                        |
| DATABASE\_\_PASSWORD                               | The password for accessing the database                                        |
| DATABASE\_\_NAME                                   | The name of the database                                                       |
| DATABASE\_\_PORT                                   | The port number of the database server                                         |
| S3\_\_REGION                                       | The AWS region of the S3 bucket                                                |
| S3\_\_ENDPOINT                                     | The endpoint URL of the S3 bucket                                              |
| S3\_\_ACCESS_KEY_ID                                | The access key ID for accessing the S3 bucket                                  |
| S3\_\_SECRET_ACCESS_KEY                            | The secret access key for accessing the S3 bucket                              |
| S3\_\_BUCKET                                       | The name of the S3 bucket                                                      |
| SIDEKIQ\_\_USERNAME                                | The username for accessing the Sidekiq web interface                           |
| SIDEKIQ\_\_PASSWORD                                | The password for accessing the Sidekiq web interface                           |
| REDIS_SENTINEL\_\_HOST                             | The host name or IP address of the Redis Sentinel server                       |
| REDIS_SENTINEL\_\_PORT                             | The port number of the Redis Sentinel server                                   |
| REDIS_SENTINEL\_\_PASSWORD                         | The password for accessing the Redis Sentinel server                           |
| REDIS_SENTINEL\_\_MASTER                           | The name of the Redis Sentinel master                                          |
| REDIS\_\_PASSWORD                                  | The password for accessing the Redis server                                    |
| REDIS\_\_DB                                        | The number of the Redis database                                               |
| SIDEKIQ\_\_REDIS_DB                                | The number of the Redis database for Sidekiq                                   |
| SENTRY\_\_DSN                                      | The data source name (DSN) for Sentry error tracking                           |
| SENTRY\_\_TRACE_RATE                               | The sampling rate for Sentry performance tracing                               |
| SENTRY\_\_ENVIRONMENT                              | The environment name for Sentry error tracking                                 |
| GATEWAY\_\_CERTIFICATE                             | The certificate file for accessing the gateway service                         |
| PROVINCE_SERVICE\_\_URL                            | The URL of the province service                                                |
| DISTRICT_SERVICE\_\_URL                            | The URL of the district service                                                |
| MESSAGING_API\_\_EXCHANGE_NAME                     | The name of the exchange for messaging API                                     |
| NOTIFICATION\_\_WORKFLOW_TRANSITION_EMAIL_TEMPLATE | The email template ID for workflow transition notification                     |
| RABBITMQ\_\_HOST                                   | The host name or IP address of the RabbitMQ server                             |
| RABBITMQ\_\_PORT                                   | The port number of the RabbitMQ server                                         |
| RABBITMQ\_\_VHOS                                   | The virtual host name of the RabbitMQ server                                   |
| RABBITMQ\_\_USERNAME                               | The username for accessing the RabbitMQ server                                 |
| RABBITMQ\_\_PASSWORD                               | The password for accessing the RabbitMQ server                                 |
| RABBITMQ\_\_MAX_ATTEMPTS                           | The maximum number of attempts for retrying failed messages in RabbitMQ queues |
| RABBITMQ\_\_RETRY_DELAY_IN_SECONDS                 | The delay in seconds between each retry attempt in RabbitMQ queues             |
| TAX_CORPORATE_REGISTRATION_PORTAL\_\_URL           | The URL of the tax corporate registration portal                               |
| EVENTBUS\_\_EXCHANGE_NAME                          | The name of the exchange for event bus                                         |

In addition to these common environment variables, some applications may have specific environment variables that are related to their functionality or dependencies. These variables are prefixed with the name of the application or service that they belong to, such as `PROVINCE_SERVICE__URL` or `TAX_CORPORATE_REGISTRATION_PORTAL__URL`. These variables are documented in their respective application repositories or README files.
