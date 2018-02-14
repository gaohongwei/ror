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


  Expect Exceptions to be raised in rspec
  expect { object.some_method("Stupid Monkey") }.to raise_error
  expect { object.some_other_method }.to raise_error "Awful exception"
  expect { object.method("argparty") }.to raise_error ErrorClass



  it "should call 'bar' with appropriate arguments" do
     subject.stub(:bar)
     subject.foo
     expect(subject).to have_received(:bar).with("Invalid number of arguments")
  end
