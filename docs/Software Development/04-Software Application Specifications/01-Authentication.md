# Authentication

Unless specified explicitly per project, all applications that need to use an authentication scheme, must use DIT's Central Authentication Service (CAS) for that purpose. 

## URLs

Use __https://auth.dev.krd__ in `dev`, `staging`, and `pre-prod` environment. 

Use __https://account.id.krd__ in production environment. 

## OpenID Connect

The CAS is an OpenID Connect-compatible service. It strictly follows the specifications of OpenID Connect to perform authentication. 

### Discovery

It provides a discovery endpoint for dynamic information discovery at the endpoint `/.well-known/openid-configuration`

## OAuth 2.0

The CAS is an OAuth 2.0-compatible service. It strictly follows the specifications of OAuth 2.0 to perform authorization.

### Flows

Among the different authorization flows supported by our CAS, we only permit the followings to be used:

* Authorization Code with PKCE
* Implicit 
* Client Credentials

#### Authorization Code with PCKE 

When using this flow, we prohibit access tokens to be stored on the client-side due to security concerns. All access tokens, refresh tokens, and ID tokens must be concealed and be kept from the browser or any other client that is prone to exposure. 

For that, we follow the Backend for Frontends Pattern to safely store access tokens. Take a look at our [Backend for Frontends](https://github.com/ditkrg/Backend-for-Frontends-Template) implementation, which we mainly use for this flow. 

If you are about to use this flow, speak to the Head of Digital Development and DevOps to set the Backend for Frontends according to your needs. Otherwise, it is considered to be an application bug.

## Authentication Strategy

When using the CAS for authentication, the method through which authentication is ensured is the validation of access tokens that is received in a Authorization Bearer header. 

Access tokens from the CAS are JWTs.

When validating the access token, it is important to check:

1. `iss` claim: the Issuer, which corresponds to the URLs in this section. 
2. `exp` claim: the expiration of the token. Only valid tokens must be allowed.
3. `aud` claim: the audience. This corresponds to the name of the your application as a protected resource in the CAS.
4. `alg`: the algorithm, which must be `RS256`.
5. `kid`: which is the key with which the token is signed. For this, you will need to use the JWKS endpoint (refer to Discovery in this section) to verify the public key. 

## User On-boarding

Most applications are generally designed to deal with end-users. This means that beyond authentication strategies, applications must store user information to some extent. Since all users are centrally registered in the CAS, applications that use the CAS will delegate registration and authentication to it. Accordingly, applications will need a way to make sure that only specified users can access the given applications. Apparently, not all users registered in the CAS can access all applications that utilize the CAS. 

### CAS API

For that, applications may request to search in the CAS in order to on-board users to their system using the CAS API.

#### URLs

Use __https://api.auth.dev.krd__ in `dev`, `staging`, and `pre-prod` environment. 

Use __https://api.account.id.krd__ in production environment. 

#### Authentication Flow

To authenticate your application to use the CAS API, use a `client credentials` flow with a Client ID and a Client Secret. Request a development Client ID & Secret from the Head of DevOps. 

#### Required Scopes

To use the CAS API for user on-boarding, two scopes are required:

* adminui-api-wrapper
* adminui-api-wrapper.users.search

#### Endpoints

Once you have a valid access token, you can send the token as a Authorization Bearer header. [Checkout the Swagger Documentations of the CAS API](http://api.auth.dev.krd/swagger)