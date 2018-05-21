https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods


GET, query
POST,  create, data includes full resource data
PUT,   update, idempotent, data includes full resource data

PATCH, update, non-idempotent, apply partial modifications to the resource.
Patch only send the data that we need to modify 
without modifying or effecting other parts of the data. 
Ex: if we need to update only the first name, we pass only the first name.

HEAD
The HEAD method asks for a response identical to that of a GET request, 
but without the response body.
useful for checking what a GET request will return 
before actually making a GET request 
-- like before downloading a large file or response body.

DELETE
The DELETE method deletes the specified resource.

OPTIONS
The OPTIONS method is used to describe the communication options for the target resource.
