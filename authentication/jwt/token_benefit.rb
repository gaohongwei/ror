Benefits of Token-based Authentication

Stateless
  Tokens are stateless. There is no need to keep a session store since 
  the token is a self-contained entity that stores all the user information in it.

Decoupling
  You are no longer tied to a particular authentication scheme. 
  Tokens may be generated anywhere, so the API can be called from anywhere 
  with a single authenticated command rather than multiple authenticated calls.

Mobile Ready
  Cookies are a problem when it comes to storing user information in native mobile applications. 
  Adopting a token-based approach simplifies this saving process significantly.

Performance
  In terms of server-side load, reduce one network roundtrip (e.g. finding a session on a database) 
  One network query is likely to take more time than calculating an HMACSHA256 code to validate a token and parsing its contents. 
  This makes token-based authentication faster than the traditional alternative.

Cookies
  Cross-domain / CORS
    Cookies and CORS dont mix well across different domains. 
    A token-based approach allows you to make AJAX calls to any server, on any domain, 
    because you use an HTTP header to transmit the user information.


  CSRF (Cross Site Request Forgery)
    Because the application does not rely on cookies for authentication, 
    it is invulnerable to cross-site request attacks.
