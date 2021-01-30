https://www.pluralsight.com/guides/ruby-ruby-on-rails/ruby-on-rails-nested-attributes
class Variant < ActiveRecord::Base
  belongs_to :product
  # Attributes: name:string, price:float
end
class Image < ActiveRecord::Base
  belongs_to :product
  # Attributes: url:string, alt:string caption:string
end
class Product < ActiveRecord::Base
  has_many :variants
  accepts_nested_attributes_for :image
end

def product_params
  params.require(:product).permit(
    :name, :price,
    image_attributes: [ :id, :url, :alt, :caption ]
  )
end

= form_for @product do |f|

  // Product attributes
  .form-group
    = f.label :name
    = f.text_field :name  
  .form-group
    = f.label :price
    = f.text_field :price

  // Image attributes
  = f.fields_for :image do |f|
    = f.label :url
    = f.text_field :url

    = f.label :alt
    = f.text_field :alt

    = f.label :caption
    = f.text_field :caption

  = f.submit


