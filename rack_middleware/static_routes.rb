http://kmikael.com/2013/05/28/creating-static-sites-in-ruby-with-rack/

use Rack::Static,
  :urls => ["/asset", ],
  :root => "public/swagger-ui",
  :index => 'index.html',
  :header_rules => [[:all, {'Cache-Control' => 'public, max-age=3600'}]]
  
  
use Rack::Static, :urls => {"/doc" => 'index.html', "/docs" => 'index.html', "/index" => 'index.html', "/index.html" => 'index.html'}, :root => 'public/swagger-ui/'
use Rack::Static, :urls => ["/asset"], :root => "public/swagger-ui"
