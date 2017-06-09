These are 10 best practices to design a clean RESTful API:
https://blog.mwaysolutions.com/2014/06/05/10-best-practices-for-better-restful-api/

Use Restful Name and action
Resources and sub-resources
   1. GET method and query parameters should not alter the state
   Use PUT, POST and DELETE methods  instead of the GET method to alter the state.
   Do not use GET for state changes:
   2. Use nouns but no verbs
   3. Use plural nouns
   Do not mix up singular and plural nouns. 
   Keep it simple and use only plural nouns for all resources.
   4. Use sub-resources for relations
     If a resource is related to another resource use subresources.

     GET /cars/711/drivers/ Returns a list of drivers for car 711
     GET /cars/711/drivers/4 Returns driver #4 for car 711


5. Use HTTP headers for serialization formats

Both, client and server, need to know which format is used for the communication. The format has to be specified in the HTTP-Header.

Content-Type defines the request format.
Accept defines a list of acceptable response formats.

7. Provide filtering, sorting, field selection and paging for collections
9. Handle Errors with HTTP status codes

It is hard to work with an API that ignores error handling. Pure returning of a HTTP 500 with a stacktrace is not very helpful.
Use HTTP status codes

Use error payloads
All exceptions should be mapped in an error payload. Here is an example how a JSON payload should look like.
 

Always use ssl connection
Authentication
With ssl, access token can be used for authentication
Cache
8. Version your API
Make the API Version mandatory and do not release an unversioned API. 
 Use a simple ordinal number and avoid dot notation such as 2.5.
We are using the url for the API versioning starting with the letter „v“
/blog/api/v1
6. Use HATEOAS
Hypermedia as the Engine of Application State is a principle that hypertext links should be used to create a better navigation through the API.

10. Allow overriding HTTP method
Some proxies support only POST and GET methods. To support a RESTful API with these limitations, 
 the API needs a way to override the HTTP method.
Use the custom HTTP Header X-HTTP-Method-Override to overrider the POST Method.
