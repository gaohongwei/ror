rails g scaffold disease name:string 
rails g scaffold symptom name:string
rails g scaffold disease_symptom disease_id:integer symptom_id:integer --skip-controller


class Symptom < ActiveRecord::Base
  has_many :disease_symptoms
  has_many :diseases, :through => :disease_symptoms
end

class Disease < ActiveRecord::Base
  has_many :disease_symptoms
  has_many :symptoms, :through => :disease_symptoms
end

class DiseaseSymptom < ActiveRecord::Base
  belongs_to :disease
  belongs_to :symptom
end

<%= semantic_form_for @disease do |f| %>
  <%= f.inputs do %>
    <%= f.input :name %>
    <%= f.input :symptoms, :as => :check_boxes, :required => false %>
<%= f.actions %>
  <% end %>
<% end %>
