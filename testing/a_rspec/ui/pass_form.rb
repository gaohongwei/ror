require 'rails_helper'
include SimpleForm::ActionViewExtensions::FormHelper

RSpec.describe 'p1.html.slim', type: :view do
  include Devise::TestHelpers
  let(:admin) { FactoryGirl.create(:admin) }
  before do
    @data = FactoryGirl.create(:model_factory)
    simple_form_for(@data) { |f| @form = f }
    @form.simple_fields_for(:rules) { |f| @form2 = f }
  end
  describe 'activity fields' do
    it 'show div' do
      render 'partial', f: @form2
      expect(rendered).to have_tag(:td, text: 'my div')
    end
  end
end



  let(:form) do
    my_form = nil
    simple_form_for(user_activity_policy) { |f| my_form = f }
    my_form
  end
