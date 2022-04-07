# Checklist for Microservices

Use the following checklist when dealing with a microservices architecture internally with DIT. This guide is intended for use among DIT software developers. 

| ID     | Name                                           | Description                                                  |
| ------ | ---------------------------------------------- | ------------------------------------------------------------ |
| SMR-1  | Authentication                                 | Check the presence of these two parameters in the request headers:<br />* X-Auth-User<br />* X-Auth-Signature<br /><br />Verify the signature in X-Auth-Signature with a given public key. |
| SMR-2  | Database per service pattern                   | Separate your microservice's database from the rest of the services. |
| SMR-3  | Events: Use Cloud Native Events                | Use Cloud Native Events envelope format to publish messages to the message broker.<br />For the data property, use JSONAPI Specs (see SMR-9). |
| SMR-4  | Events: Idempotent Consumers                   | Make your consumers idempotent by processing messages with the same event id once. |
| SMR-5  | Events: Transactional Outbox                   | Make publishing of events atomic along with operation applied on the corresponding resource. |
| SMR-6  | Events: Polling Publisher Pattern              | Have a worker that uses polling to read unpublished messages and push them to the message broker |
| SMR-7  | Events: Single Exchange, Multiple Routing Keys | Use a single exchange to publish message to a message broker, but utilize routing keys. |
| SMR-8  | Events: Follow Naming Conventions              | Use the following convention to name your routing keys: Annex 1.1<br />Use the followiing convetnions to name your queues: Annex 1.2 |
| SMR-9  | REST: Adopt JSON API Specs                     | Fully adopt the JSONAPI Specs for responses.<br />           |
| SMR-10 | REST: JSONAPI Pagination Extension             | Use the following JSONAPI extension for pagination in responses: See Annex 2 |
| SMR-11 | REST: JSONAPI Request Extension                | Use the following JSONAPI extension for requests: Annex 3    |
| SMR-12 | REST: Async Request Reply Pattern              | Use the Asynchronous Request Reply Pattern when dealing with computationally-intesive tasks that spans multiple microservices. See Annex 4.<br />The proper HTTP Code for this response is 202 ACCEPTED |
| SMR-13 | REST: Use Camel Case for JSONAPI Member Names  | Use Camel Case for naming members in JSONAPI specs.          |
| SMR-14 | REST: Use Idempotency Key                      | For POST, DELETE and PATCH requests, require header Idempotency-Key to be present. Process requests with the same idempotency key only once. |
| SMR-15 | REST: Use Kebab-case for endpoint names        | Use Kebab-case to name your REST endpoints.                  |
| SMR-16 | Use Open API for REST Documentation            | Use Open API >= 3 to document REST endpoint                  |
| SMR-17 | Use AsyncAPI For Events Documentation          | Use AsyncAPI >= 2 to document Events.                        |
| SMR-18 | Pagination must start from 1, not 0            | Pagination must start from page 1. This means that at Page 1, the offset is 0. |




## Annexes

### Annex 1

1. [api name]-api.[resource name in plural form].[operation type in past tense]
   Example: *users-api.users.created
2. [api name]-api.[routing key of the listenting queue]
   Example: orders-api.users-api.users.created

### Annex 2

```JSON
{
  meta: {
    page: {
      totalPages: "integer"
      count: "integer",
      limitValue:	"integer",
      currentPage:	"integer"
    }
  }
}
```



### Annex 3

```json
{
  data: {...request_payload}
}
```



### Annex 4

```JSON
{
  data: {
    id: "string",
    type: "async_request_responses",
    attributes: {
      retryAt: "string(datetime)",
      location: "string"
    }
  }
}
```

