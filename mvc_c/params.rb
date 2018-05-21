
The params in a controller looks like a Hash, 
but it's actually an instance of ActionController::Parameters, 
which provides several methods such as require and permit.

The require method ensures that a specific parameter is present, 
otherwise the require method throws an error 
It returns an instance of ActionController::Parameters for the key passed into require.

The permit method returns a copy of the parameters object, 
returning only the permitted keys and values. 
When creating a new ActiveRecord model, 
only the permitted attributes are passed into the model.

It looks a lot like the whitelisting that was formerly included in ActiveRecord models, 
but it makes more sense for it to be in the controller.


Permit returns another hash that contains only the permitted key 
AND (this is critical) will respond with true to the permitted? method. 
By default, an instance of the ActionController::Parameters class will return false for permitted? 
Responding true to permitted? means the parameter object can be used in mass assignment; 
else the app will throw a ForbiddenAttributes error. 
