    @cols={
      id:{
        header: "Row ID",
        url: {fmt:"#{events_path}/%s",  props:['id']}
        },
      cs_user:{
        header: "cs_user Name",
        url: {fmt:"#{users_path}/%s", values:['fixed'], props:['cs_uid']}
      },
      domain:{
        header:"Domain Name",
        url: {fmt:'/domains/%s',  props:['id']},
        img: 'img_fname', # this is an attribute, should use image_path()
        },
      email:{
        url: 'www.google.com',
      }
    }
    
  def display_col(col_value,col_def,row)
    case col_def.class.name
    when 'String'
      col_value
    when 'Hash'
      url = col_def[:url]
      img = col_def[:img]
      if img
          fname= row.send('img_fname')
          image_path(fname)
      if url
        case url.class.name
        when 'String'
          link_to col_value, url
        when 'Hash'
          fmt=url[:fmt]
          values=url[:values]
          props=url[:props]
          unless values
            values=props.map{|prop|row.send(prop)}
          end
          link=fmt%values if values
          link_to col_value, link
        end
      else
        col_value
      end
    else
      col_value
    end
  end

.main-column
  .tab-content
    .tab-pane.active
      .panel
        table#table.table.table-hover.table-condensed.valign-middle
          thead
            tr
              - cols.keys.each do |col|
                th = cols[col][:header]||col
          tbody#table-rows
            - rows.each do |row|
              tr id="#{row.try(:id)}"
                - cols.keys.each do |col|
                  td = display_col(row[col],cols[col],row)
