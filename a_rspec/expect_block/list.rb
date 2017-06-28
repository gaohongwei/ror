  expect do
    
  end.to raise_error

  expect do

  end.to change { described_class.count }.by(1)

  expect do
    get :show, id: @obj.to_param 
  end.to raise_error(RailsParam::Param::InvalidParameterError,"Error msg")
