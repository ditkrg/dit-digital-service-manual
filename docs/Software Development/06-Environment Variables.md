# Environment Variables for Micro-Service Applications

This document provides a brief description of the environment variables that are used by the micro-service applications developed and maintained by the Department of Information & Technology (DIT). These variables are used to configure various aspects of the applications, such as database connections, cloud storage access, message queue settings, etc. The environment variables follow a standard naming convention that consists of two parts: the prefix and the suffix. The prefix indicates the component or service that the variable belongs to, and the suffix indicates the specific parameter or attribute that the variable represents. For example, `DATABASE__HOST` is an environment variable that specifies the host name of the database server for the application.

The following table lists the environment variables that are common to all DIT micro-service applications, along with their descriptions.

| Environment Variable          | Description                                                               |
| :---------------------------- | :------------------------------------------------------------------------ |
| CAS\_\_URL                    | URL for the Central Authentication Service (CAS)                          |
| CAS\_\_M2M_CLIENT_ID          | Client ID for machine-to-machine authentication with the CAS              |
| CAS\_\_M2M_CLIENT_SECRET      | Client secret for machine-to-machine authentication with the CAS          |
| DATABASE\_\_CONNECTION_STRING | The connection string of database server                                  |
| DATABASE\_\_URL               | The URL format for the connection string of database server               |
| DATABASE\_\_HOST              | The host name or IP address of the database server                        |
| DATABASE\_\_USERNAME          | The username for accessing the database                                   |
| DATABASE\_\_PASSWORD          | The password for accessing the database                                   |
| DATABASE\_\_NAME              | The name of the database                                                  |
| DATABASE\_\_PORT              | The port number of the database server                                    |
| S3\_\_ENDPOINT                | The endpoint URL of the S3 bucket                                         |
| S3\_\_ACCESS_KEY_ID           | The access key ID for accessing the S3 bucket                             |
| S3\_\_SECRET_ACCESS_KEY       | The secret access key for accessing the S3 bucket                         |
| S3\_\_SELF_BUCKET             | The name of the S3 bucket used for storing self-related files             |
| S3\_\_UPLOADS_API_BUCKET      | The name of the S3 bucket used for storing uploaded files via Uploads API |
| SIDEKIQ\_\_USERNAME           | The username for accessing the Sidekiq web interface                      |
| SIDEKIQ\_\_PASSWORD           | The password for accessing the Sidekiq web interface                      |
| REDIS\_\_CONNECTION_STRING    | The connection string of redis database server                            |
| REDIS_SENTINEL\_\_HOST        | The host name or IP address of the Redis Sentinel server                  |
| REDIS_SENTINEL\_\_PORT        | The port number of the Redis Sentinel server                              |
| REDIS_SENTINEL\_\_PASSWORD    | The password for accessing the Redis Sentinel server                      |
| REDIS_SENTINEL\_\_MASTER      | The name of the Redis Sentinel master                                     |
| REDIS\_\_PASSWORD             | The password for accessing the Redis server                               |
| REDIS\_\_DB                   | The number of the Redis database                                          |
| SIDEKIQ\_\_REDIS_DB           | The number of the Redis database for Sidekiq                              |
| SENTRY\_\_DSN                 | The data source name (DSN) for Sentry error tracking                      |
| SENTRY\_\_TRACE_RATE          | The sampling rate for Sentry performance tracing                          |
| SENTRY\_\_ENVIRONMENT         | The environment name for Sentry error tracking                            |
| GATEWAY\_\_CERTIFICATE        | The certificate file for accessing the gateway service                    |
| RABBITMQ\_\_URL               | The URL the RabbitMQ server                                               |
| RABBITMQ\_\_HOST              | The host name or IP address of the RabbitMQ server                        |
| RABBITMQ\_\_PORT              | The port number of the RabbitMQ server                                    |
| RABBITMQ\_\_VHOST             | The virtual host name of the RabbitMQ server                              |
| RABBITMQ\_\_USERNAME          | The username for accessing the RabbitMQ server                            |
| RABBITMQ\_\_PASSWORD          | The password for accessing the RabbitMQ server                            |
| RABBITMQ\_\_EXCHANGE_NAME     | The name of the exchange for RabbitMQ server                              |

## Environment Variables for Micro-Service Applications

1. Use double underscores (\_\_) to separate words in the variable name.
2. Use all uppercase letters for the variable name.
3. Use descriptive names for the variable that indicate their purpose or usage.
4. Use consistent naming across all microservice applications developed by DIT.
5. Store environment variables securely, using an encrypted secrets store, such as HashiCorp Vault or Amazon Secrets Manager.
6. Avoid hard-coding sensitive information, such as passwords or API keys, in the code.

## Conclusion

The standard naming convention for environment variables used by microservice applications developed and maintained by the Department of Information & Technology (DIT) has been outlined in this document. Following these guidelines will ensure consistency and clarity across all microservice applications developed by DIT.
