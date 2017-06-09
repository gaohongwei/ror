
Just a quick warning: 
when you use ActiveRecord::Base.connection.execute 
you get a Mysql::Result instance, 
this is a very thin wrapper around the actual result returned from libmysqlclient. 
This means you have to free the memory of the result table, 
failing to do so will result in erratic query times 
because somewhere a garbage collector will do it for you.
class Person < ActiveRecord::Base
  # Returns the last name of someone given the ID
  def self.last_name(id)
    result = connection.execute("SELECT last_name FROM people" +
      " WHERE id = %d" % id)
    last_name = result.fetch_row.first
    result.free
    last_name
  end
end

class Person < ActiveRecord::Base
  set_table_name "person"
  set_primary_key "person_id"
end

criteria = [{column: 'name', value: 'Jamie', operator: '=', and_or: 'and'}, 
            {column: 'age', value: 20, operator: '>' }]
query = criteria.map do |h| 
  "#{h[:column]} #{h[:operator]} ? #{h[:and_or]||''}" 
end.join(' ')

MyModel.where(query, *criteria.map { |h| h[:value] })

