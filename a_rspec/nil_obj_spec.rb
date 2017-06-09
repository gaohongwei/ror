

it 'table_rows works with nil event' do
  events = Kaminari.paginate_array([nil], total_count: 1).page(nil).per(25)
  events = Kaminari.paginate_array([Elasticsearch::Model::Response::Result.new], total_count: 1).page(nil).per(25)
  render 'table_rows', events: events
  expect(rendered).to match %r{<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>}
end
