javascript_include_tag "common.javascript", "/elsewhere/cools"
# => <script src="/assets/common.javascript?1284139606"></script>
#    <script src="/elsewhere/cools.js?1423139606"></script>


<%= stylesheet_link_tag    "application", :media => "all" %>
will include the stylesheet named application.css, you can have files like application.css.sass or application.css.scss or any other extensions and rails will compile the css file with the right stylesheet engine and serve the application.css file.

The attribute "media=all" is actually a css attribute, which means that the css will be included for all the medias, like when browsing the website, when printing the screen, etc. You can find more information about the media attribute on this link.


One of the most important features of style sheets is that they specify how a document is to be presented on different media: on the screen, on paper, with a speech synthesizer, with a braille device, etc.

    %style{ type: 'text/css' }= yield :css

You can add a stylesheet tag inside the head tag of the layout by doing something like this:

layouts/products.html.erb:

<head>
  ...
  <%= yield :css %>
  ...
</head>
products/edit.html.erb

  <% content_for 'css' do
    stylesheet_link_tag 'products_edit'
  end %>
