# Statelessness 

## Intro
Distributed applications must maintain statelessness all during its life cycle. This is a founding principle of all distributed systems. 

## HTTP

By nature, HTTP is a stateless protocol. This means that the server that receives the HTTP requests blindly serve the request and does not associate requests with any previous information. There is no special treatment for different requests, unless the server does this explicitly through attaching some state to incoming requests, usually through sessions. We will elaborate this in the upcoming sections. 

## Sessions

Application server sessions are stateful. They do attach some sort of a meaning to each request, which in turn instructs the server to treat HTTP requests differently. This is a clear violation of the statelessness principle of HTTP. We encourage you to move away from sessions that are stored on the corresponding server. 

In a distributed system where multiple instances of the same application are running to serve requests, HTTP requests that are forwarded to these instances are never guaranteed to arrive at the same instance. Therefore, a request that has initially arrived at Instance #1, may later arrive at Instance #2. If server sessions are involved, this will be problematic as the session data on Instance #1 does not exist on Instance #2, resulting in a state contention. 

The solution to this is either: 

1. Store session information in an external data store such as Redis so that it is accessible by all instances.
2. Use sticky sessions.
3. Avoid using server sessions.

We highly encourage you to use Solution #1. 

When using sticky sessions, please speak to the Head of DevOps to obtain approval on the implementation details.

## Storage

In a distributed system, files must not be stored locally on the host machine. Rather, a storage service must be used. 

The supported storage services:
1. DIT provides an on-prem, S3-compatible blob storage service. 
2. Persistent volumes can be attached to running containers (Only When Required).

Please speak to the Head of DevOps to obtain the necessary information in this regard.