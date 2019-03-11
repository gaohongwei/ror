For when you want to render only part of a form from a partial:

# In app/admin/foos.rb
  render partial: 'bar_inputs', locals: { f: f }
app/views/active_admin/resource/_bar_inputs.html.arb
  f.inputs 'Some fields' do
    f.input :name
    f.input :title
    f.input :description
  end
