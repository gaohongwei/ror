      expect(rendered).to have_tag('div', with: { class: 'rule-info rule-type-row rule-hover clearfix'}) do
        with_tag 'input', with: { type: 'radio', name: 'search[days]', id: '1', value: '1' }
        with_tag 'input', with: { type: 'radio', name: 'search[days]', id: '7', value: '7' }
        with_tag 'input', with: { type: 'radio', name: 'search[days]', id: '30', value: '30' }
        with_tag 'input', with: { type: 'radio', name: 'search[days]', id: '365', value: '365' }
      end

    expect(rendered).to have_tag('tr') do
      with_tag 'th', text: 'NAME'
      with_tag 'th', text: 'IP ADDRESS'
      with_tag 'th', text: 'FACILITY'
      with_tag 'th', text: 'FORMAT'
    end
    expect(rendered).to have_tag('tr') do
      with_tag 'th', text: 'CLIENT'
      with_tag 'th', text: 'CLIENT'
    end
### Complaicted case
  it 'has the layout, syslog app section and syslog receiver section' do
    render
    expect(rendered).to have_tag('div', with: {class: 'row'}) do
      with_tag 'div', with: {class: 'col-md-3'} do
        with_tag('div', with: {class: 'panel panel-default license page-header', id: 'table_syslog_app'})
      end
      with_tag 'div', with: {class: 'row'}
      with_tag 'div', with: {class: 'col-md-9'} do
        with_tag('div', with: {class: 'panel panel-default license page-header', id: 'table_syslog_receiver'})
      end
    end
  end
