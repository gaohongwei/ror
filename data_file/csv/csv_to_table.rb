controller:
    @csv_table = CSV.open(fname_with_path, :headers => true).read
    
view:
<table border="0" cellspacing="5" cellpadding="5">
  <tr>
  <% @csv_table.headers.each do |header| %>
    <th><%= header %></th>
  <% end %>
  </tr>
  <% @csv_table.each do |row| %>
    <tr>
    <% row.each do |key, value| %>
      <td><%= value %></td>
    <% end %>
    </tr>
  <% end %>
</table>
