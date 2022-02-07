# DevOps Requirements

## Health Check

All web application are required to provide a `GET /health` endpoint that will return a `200` HTTP Response Code if: 

1. The application was bootstrapped successful and
2. Necessary connections to different data sources can be established and
3. Connection to depending services can be established

If these conditions cannot be met, the endpoint must return a `503` HTTP Response Code. 

## Status 

All web application are required to provide a `GET /status` endpoint with a similar response schema and a `200` HTTP Response Code: 

```json
{
    "name": {
        "type": "string",
        "description": "The application name"
    },
    "version": {
        "type": "string",
        "description": "The version of the application"
    },
    "startTime": {
        "type": "string",
        "format": "date-time",
        "description": "The start time when the application was successfully booted"
    },
    "host": {
        "type": "string",
        "description": "The name of the host machine on which the application is running"
    }
}
```

Example:
```json
{
   "name":"simple-api",
   "version":"0.1.0",
   "startTime":"2021-10-28T14:49:08.06+00:00",
   "host":"simple-api-deployment-c99cdcfdf-xrfh4"
}
```

