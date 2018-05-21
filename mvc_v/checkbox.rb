#Display boolean as checkbox, true or false
#Display checkbox on the same line as label
div
  = f.input_field :is_boolean, as: :boolean, label: false
  = ' This is my label'

# Show a list of checkboxes
= f.input_field :file_types, as: :check_boxes, collection: [['file','file'], ['folder','folder']]  
= f.collection_check_boxes :file_types,[['file','File'],['report','Report']], :first, :last
= f.input_field :event_types, as: :check_boxes, collection: [['previewed','previewed'], ['downloded','downloded']]
= f.input_field :types, as: :check_boxes, collection: [['box','box'], ['o365','o365']]
= f.input_field :file_types, as: :check_boxes, collection: [['file','file'], ['folder','folder']]  

Checkbox lable on the right or left
= f.input :check_me, as: :boolean, inline_label: 'Right'
= f.input :check_me, as: :boolean, label: 'left'

=form.input :box_apps, collection: box_apps, 
as: :check_boxes, 
label: false, 
wrapper: 'checkbox',
value_method:'uid',
label_method: lambda { |obj| image_tag('logo_box.png', class: 'logo-box-sm')  +label_tag(obj.name)}

=form.input :box_apps, collection: box_apps, 
as: :chk_box, 
label: false, 
wrapper: 'checkbox',
value_method:'uid', 
img: '/assets/logo_box.png'
#app/inputs/chk_box_input.rb
class ChkBoxInput < SimpleForm::Inputs::CollectionCheckBoxesInput
  def input(_wrapper_options)
    label_method, value_method = detect_collection_methods
    options[:collection_wrapper_tag] = 'div'
    options[:collection_wrapper_class] = 'grouped inline fields'
    img_file=options[:img]
    template.content_tag(:div, class: 'form-inline.margin-sm') do
    #tpl = "<td><img class='logo-google-sm' src=#{img_file}></td><td>"

    tpl=content_tag(:td, tag(:img,src:img_file,class:'logo-google-sm'),class: 'fixed-logo')
    tpl.concat(content_tag(:td,
      @builder.send("collection_check_boxes",
      attribute_name, collection, value_method, label_method,
      input_options, input_html_options,
      &collection_block_for_nested_boolean_style
    )))
    template.concat tpl.html_safe
    end
  end
end

