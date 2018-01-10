  expect do
    
  end.to raise_error

  expect do

  end.to change { described_class.count }.by(1)

  expect do
    get :show, id: @obj.to_param 
  end.to raise_error(RailsParam::Param::InvalidParameterError,"Error msg")

expect{Object.non_existent_message}.to raise_error(NameError)
expect{Object.non_existent_message}.to raise_error
expect(ErrorMailer).to receive(:send_email).with(email_subject, email_body)
