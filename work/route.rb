http://guides.rubyonrails.org/routing.html#defining-multiple-resources-at-the-same-time
If you want to route /articles (without the prefix /admin) to Admin::ArticlesController, you could use:
/articles => Admin::ArticlesController
scope module: 'admin' do
  resources :articles, :comments
end
or, for a single case:

resources :articles, module: 'admin'
If you want to route /admin/articles to ArticlesController (without the Admin:: module prefix), you could use:
/admin/articles => ArticlesController
scope '/admin' do
  resources :articles, :comments
end
or, for a single case:

resources :articles, path: '/admin/articles'

