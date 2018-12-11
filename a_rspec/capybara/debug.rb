# find
  dom = page.find('#active_table')
  dom.has_content?(request.title)
  page.find('.myclass').find(:xpath, './div')

  dom.native.text
