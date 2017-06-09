
    
Login
curl -X POST -i -H "Content-type: application/json" -c cookies.txt -X POST 
http://192.168.138.129:3000/api/v1/articles -d '
    {
        "username":"user",
        "password":"password"
    }
    '    

Create without login
curl -i -H "Content-type: application/json"  -X POST 
http://192.168.138.129:3000/api/v1/articles -d '
{"content":"<p>Try2</p>\n", "permalink":"www.google.com", "source_site":"www.google.com", "title":"Try2"}
    '

Create with login
curl -i -H "Content-type: application/json" -c cookies.txt -X POST 
http://192.168.138.129:3000/api/v1/articles -d '
{"content":"<p>Try2</p>\n", "permalink":"www.google.com", "source_site":"www.google.com", "title":"Try2"}
    '

https://www.drupal.org/node/1795770
