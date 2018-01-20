https://zaiste.net/posts/concisely_about_rack_applications/
Another useful middleware is Rack::Auth::Basic. 
It can be used to protect our applications with Basic HTTP authentication.

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['admin', 'admin']
end
