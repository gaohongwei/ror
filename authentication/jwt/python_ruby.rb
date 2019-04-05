In order to exchange jwt between pyhton nd ruby
use header_fields={ typ: 'JWT' } for ruby

# rubt
  hmac_secret = 'secret'
  payload = {some: 'payload'}
  token = JWT.encode payload, hmac_secret, 'HS256',header_fields={ typ: 'JWT' }
  "eyJhbGciOiJIUzI1NiJ9.eyJzb21lIjoicGF5bG9hZCJ9.VCsg4ezefHkedcXNE3zecNjuH7LG-A5YRqAGHV1jHPE" 

# python
  >>> import jwt
  >>> encoded_jwt = jwt.encode({'some': 'payload'}, 'secret', algorithm='HS256')
  >>> encoded_jwt
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzb21lIjoicGF5bG9hZCJ9.4twFt5NiznN84AWoo1d7KO1T_yoc0Z6XOpOVswacPZg'
  >>> jwt.decode(encoded_jwt, 'secret', algorithms=['HS256'])
  {'some': 'payload'}
