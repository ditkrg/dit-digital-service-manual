# Authentication

Unless specified explicitly per project, all applications that need to use an authentication scheme, must use DIT's Central Authentication Service (CAS) for that purpose.

## URLs

Use **[https://auth.dev.krd](https://auth.dev.krd/)** in `dev`, `staging`, and `pre-prod` environment.

Use **[https://account.id.krd](https://account.id.krd/)** in production environment.

## OpenID Connect

The CAS is an OpenID Connect-compatible service. It strictly follows the specifications of OpenID Connect to perform authentication.

### Discovery

It provides a discovery endpoint for dynamic information discovery at the endpoint `/.well-known/openid-configuration`



## OAuth 2.0

The CAS is an OAuth 2.0-compatible service. It strictly follows the specifications of OAuth 2.0 to perform authorization.

### Flows

Among the different authorization flows supported by our CAS, we only permit the followings to be used:

- Authorization Code with PKCE
- Implicit
- Client Credentials

## Authentication Strategy

When using the CAS for authentication, the method through which authentication is ensured is the validation of access tokens that is received in a Authorization Bearer header.

Access tokens from the CAS are JWTs.

When validating the access token, it is important to check:

1. `iss` claim: the Issuer, which corresponds to the URLs in this section.
2. `exp` claim: the expiration of the token. Only valid tokens must be allowed.
3. `aud` claim: the audience. This corresponds to the name of the your application as a protected resource in the CAS.
4. `alg`: the algorithm, which must be `RS256`.
5. `kid`: which is the key with which the token is signed. For this, you will need to use the JWKS endpoint (refer to Discovery in this section) to verify the public key.

**Note: We highly recommend using existing packages and libraries that take care of the implementations mentioned in this guide instead of making raw HTTP requests using an HTTP client. The existing libraries are battle-tested and take care of many abstraction that you may skip.**

## Authentication Flows

### Client Credentials Flow

DIT's authentication scheme follows OpenID and OAuth2 standards. In your software requires machine-to-machine (M2M) communication, authentication can be achieved through the "client_credentials" flow.

To access the desired APIs within the DIT ecosystem, backend services must obtain an access token from the Central Authentication Service (CAS) by providing a Client ID, Client Secret, and specific scopes to which the given client can access. The CAS is OpenID-compliant and provides a discovery URL, which can be used by OpenID Clients to easily discover the specific configurations of DIT's CAS.

To obtain an M2M token, send a POST request from POSTMAN to DIT's CAS:

```
POST https://auth.dev.krd/connect/token
```

Set the Header to: `Content-Type: application/x-www-form-urlencoded`

Set the Request Body to:

```json
{
    "grant_type": "client_credentials",
    "scope": "YOUR SCOPES GO HERE (SPACE SEPARATE THEM IF MULTIPLE)",
    "client_id": "YOUR CLIENT ID",
    "client_secret": "YOUR CLIENT SECRET"
}
```

Upon successful handling of the request, the response payload will contain an access token, expiry time, token type, and requested scopes:

```json
{
    "access_token":"A LONG ACCESS TOKEN HERE",
    "expires_in":3600,
    "token_type":"Bearer",
    "scope":"YOUR REQUESTED SCOPES, SPACE SEPARATED"
}
```

You can use the access token from the response above to connect to the specific API you need.



### Authorization Code + PKCE Flow

When using this flow, we prohibit access tokens to be stored on the client-side due to security concerns. All access tokens, refresh tokens, and ID tokens must be concealed and be kept from the browser or any other client that is prone to exposure.

For that, we follow the Backend for Frontends (BFF) Pattern to safely store access tokens. Take a look at our [Backend for Frontends](https://github.com/ditkrg/Backend-for-Frontends-Template) for an implementation reference.

We highly recommend [OAuth2 Proxy](https://oauth2-proxy.github.io/oauth2-proxy/) as the go-to solution for the Backend for Frontends implementation. It's ready for use. 

If you are about to use this flow, speak to the Head of Digital Development and DevOps to set the Backend for Frontends according to your needs. Otherwise, it is considered to be an application bug.

OAuth 2.0 with Authorization Code Grant and Proof Key for Code Exchange (PKCE) is a more secure way to authenticate users in web and mobile applications, mitigating the risks associated with the traditional Authorization Code flow. Below are the technical details and steps on how this flow works. This flow shall be used whenever there is a user login involded:



1. Receive a Client ID and Client Secret from DIT for your web client.

   1. For this to happen, you must provide the callback URL that we need to register so that the user is redirected to it upon successful login.
      1. The aforementioned callback url will be validated against the `redirect_uri` in the request (See point 4 and 5 below)

2. The client generates a random string called the `code_verifier`. This should be a high-entropy cryptographic random string.

3. The `code_verifier` is hashed using SHA-256 to create the `code_challenge`. The `code_challenge` is then base64-url-encoded.

4. Authorization Request:

   - The client redirects the user to the authorization server’s authorization endpoint.

   - The request includes the following parameters:

     - `response_type=code`
     - `client_id`
     - `redirect_uri`
     - `scope`
     - `code_challenge`
     - `code_challenge_method=S256`

     Example:

     ```bash
     https://authorization-server.com/auth?
     response_type=code&
     client_id=YOUR_CLIENT_ID&
     redirect_uri=YOUR_REDIRECT_URI&
     scope=YOUR_SCOPES&
     code_challenge=YOUR_CODE_CHALLENGE&
     code_challenge_method=S256&
     state=UNIQUE_IDENTIFIER_OF_CHALLENGE
     ```

     **Note: It is crucial to store this challenge in a temporary persistent store / database and associate with a unique key. The unique, then, must be sent as a `state` to the authorization server (CAS). The `state` will later be sent back to your client in step number 5, which can be used to track down the `code_verifier`**

5. The user logs in and grants permissions to the client application.

   1. Upon successful authentication and authorization, the authorization server redirects the user back to the client’s specified `redirect_uri` with an authorization code.

   2. Example redirect:

      ```bash
      https://your-app.com/callback?code=AUTHORIZATION_CODE&state=UNIQUE_IDENTIFIER_OF_CHALLENGE 
      ```

   3. Use the value of the `state` to find the `code_verifier` that is needed in the next step (6. Token Request).

6. Token Request:

   - The client makes a POST request to the authorization server’s token endpoint to exchange the authorization code for an access token.

   - The request includes:

     - `grant_type=authorization_code`
     - `client_id`
     - `client_secret` (if applicable)
     - `redirect_uri`
     - `code` (the authorization code received in the previous step)
     - `code_verifier` (the original code verifier used to create the code challenge)

   - Example of payload sent to the token endpoint: 

     ```json
     {
         "grant_type": "authorization_code",
         "client_id": "YOUR_CLIENT_ID",
         "client_secret": "YOUR_CLIENT_SECRET", //optional
         "redirect_uri": "YOUR_REDIRECT_URI",
         "code": "AUTHORIZATION_CODE",
         "code_verifier": "YOUR_CODE_VERIFIER"
     }
     ```

     

7. Token Response:
   - The authorization server validates the `code_verifier` by hashing it and comparing it to the `code_challenge` sent in the authorization request.
   - If valid, the authorization server returns an access token (and optionally a refresh token) to the client.



### Summary

The PKCE extension provides an additional layer of security by ensuring that the authorization code can only be exchanged for an access token by the client that initiated the authorization request. This is achieved through the `code_verifier` and `code_challenge`, preventing authorization code interception attacks and enhancing the security of the OAuth 2.0 Authorization Code flow, especially for public clients like mobile and single-page applications.

### Flow Diagram

```sql
+--------+                                   +---------------+
|        |--(A) Authorization Request ------>|   Resource    |
|        |      + code_challenge             |     Owner     |
|        |                                   +---------------+
|        |
|        |<-(B) Authorization Code ---------<|
|        |                                   |
| Client |                                   |
|        |--(C) Authorization Code --------->|
|        |      + code_verifier              | Authorization |
|        |                                   |     Server    |
|        |<-(D) Access Token ---------------<|
+--------+                                   +---------------+
```

In this diagram:

- (A) The client sends an authorization request to the authorization server with a `code_challenge`.
- (B) The authorization server sends an authorization code back to the client.
- (C) The client exchanges the authorization code for an access token, including the `code_verifier`.
- (D) The authorization server validates the `code_verifier` and, if valid, issues an access token.



## User On-boarding

Most applications are generally designed to deal with end-users. This means that beyond authentication strategies, applications must store user information to some extent. Since all users are centrally registered in the CAS, applications that use the CAS will delegate registration and authentication to it. Accordingly, applications will need a way to make sure that only specified users can access the given applications. Apparently, not all users registered in the CAS can access all applications that utilize the CAS.

### CAS API

For that, applications may request to search in the CAS in order to on-board users to their system using the CAS API.

#### URLs

Use **[https://api.auth.dev.krd](https://api.auth.dev.krd/)** in `dev`, `staging`, and `pre-prod` environment.

Use **[https://api.account.id.krd](https://api.account.id.krd/)** in production environment.

#### Authentication Flow

To authenticate your application to use the CAS API, use a `client credentials` flow with a Client ID and a Client Secret. Request a development Client ID & Secret from the Head of DevOps.

#### Required Scopes

To use the CAS API for user on-boarding, two scopes are required:

- adminui-api-wrapper
- adminui-api-wrapper.users.search

#### Endpoints

Once you have a valid access token, you can send the token as a Authorization Bearer header. [Checkout the Swagger Documentations of the CAS API](http://api.auth.dev.krd/swagger)
