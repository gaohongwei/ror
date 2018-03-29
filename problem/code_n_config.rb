1. unpermitted parameters
Array or string have different format
params.require(:search).permit(:user, users: [])

2. Cannot render console from 10.0.2.2! 
Allowed networks: 127.0.0.1, ::1, 127.0.0.0/127.255.255.255
  config.web_console.whiny_requests = false

3. bootstrap css not loaded
  Check existing application.css file, should be deleted if you try to use application.scss
