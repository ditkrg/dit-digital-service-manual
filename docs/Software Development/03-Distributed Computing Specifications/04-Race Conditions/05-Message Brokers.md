# Message Brokers

When using message brokers for inter-services communications, it is worth considering situations that would result in messages that could be consumed multiple times. To resolve this, it is generally suggested to use the [Competing Consumers Pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/competing-consumers). This will make sure that messages coming from a message broker is consumed once, by design. 

## RabbitMQ 

Using RabbitMQ's queues is considered to be a safe option by itself as it achieves the Competing Consumers Pattern out of the box. 

## Kafka

When using Kafka as a message broker, make sure that consumers of the same application receive the same consumer-group-id so that only one instance of the consumers can receive the message, as opposed to all of them. 
