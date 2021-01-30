https://medium.com/@rachelchervin/how-to-create-your-own-activeadmin-routes-without-losing-the-original-590d9952f04e

How to create your own ActiveAdmin routes, without losing the original
Go to the profile of Rachel Chervin
Rachel Chervin
Oct 27, 2016
Active Admin is great, even if I wish that ugly gray background were something — anything — else. 
However, sometimes you want to add in additional controller actions to an AA model. When that time comes, use this handy trick to customize an ActiveAdmin controller method without losing the functionality of the original (built-in) method. For me, this was when I needed to update some nested association models when the parent model updated a certain field.

Inside your admin/modelname.rb, follow the following guide:

controller do
    alias_method :update_model, :update
    def update
      if resource.nesteds.any?
        resource.nesteds.each do |nested|
          nested.attribute_to_change = params[:model][:attribute_to_change]
          nested.save!
        end
      end
      update_model
    end
  end
Here, I hijacked the AA update method to check if the resource had any nested association objects. If so, I looped through the nested models and set their targeted attribute to the contents of my newly updated resource’s corresponding attribute, then saved the nested record.

Now, when I update the resource in AA, the nested association objects update themselves as well. The update_model line is very important — after my custom update action runs, update_model tells AA to run *its* update method as well, which saves the changes to my db.

h/t to Stack Overflow
