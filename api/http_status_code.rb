HTTP status codes
The HTTP standard provides over 70 status codes to describe the return values. 
We don’t need them all, but  there should be used at least a mount of 10.
  
200 – OK – Eyerything is working

200 OK - Response to a successful GET, PUT, PATCH or DELETE. 
Can also be used for a POST that doesn't result in a creation.

201 – OK – New resource has been created
201 Created - Response to a POST that results in a creation. 
Should be combined with a Location header pointing to the location of the new resource

204 No Content - Response to a successful request that won't be returning a body (like a DELETE request)
204 – OK – The resource was successfully deleted

304 – Not Modified – The client can use cached data
304 Not Modified - Used when HTTP caching headers are in play

400 Bad Request - The request is malformed, such as if the body does not parse
400 – Bad Request – The request was invalid or cannot be served. 
The exact error should be explained in the error payload. E.g. „The JSON is not valid“

401 Unauthorized - When no or invalid authentication details are provided. 
Also useful to trigger an auth popup if the API is used from a browser
401 – Unauthorized – The request requires an user authentication

403 – Forbidden – The server understood the request, but is refusing it or the access is not allowed.
403 Forbidden - When authentication succeeded but authenticated user doesn't have access to the resource

404 – Not found – There is no resource behind the URI.
404 Not Found - When a non-existent resource is requested

405 Method Not Allowed - When an HTTP method is being requested that isn't allowed for the authenticated user
410 Gone - Indicates that the resource at this end point is no longer available. 
Useful as a blanket response for old API versions

415 Unsupported Media Type - If incorrect content type was provided as part of the request

422 – Unprocessable Entity – Should be used if the server cannot process the enitity, e.g. 
if an image cannot be formatted or mandatory fields are missing in the payload.
422 Unprocessable Entity - Used for validation errors

429 Too Many Requests - When a request is rejected due to rate limiting

500 – Internal Server Error – API developers should avoid this error. 
If an error occurs in the global catch blog, the stracktrace should be logged and not returned as response.
