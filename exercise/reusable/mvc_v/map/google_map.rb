def full_address
  [address, address_details, city, state, country].reject(&:blank?).join(', ')
end
  
query = full_address
map_source = 'https://www.google.com/maps/embed/v1/place?'
map_source << "key=#{API_KEYS['google']}"
map_source << "&q=#{query}"
iframe src: map_source,
       width: '100%',
       height: '300px',
       frameborder: '0',
       style: 'border: 0'
