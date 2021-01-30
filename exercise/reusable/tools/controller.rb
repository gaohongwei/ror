<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < AdminController


  private
    # Use callbacks to share common setup or constraints between actions.
    # Only allow a trusted parameter "white list" through.
    def get_params
      <%- if attributes_names.empty? -%>
      params[<%= ":#{singular_table_name}" %>]
      <%- else -%>
      #params.require(<%=":#{class_name.split(':').last.downcase}"%>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      params.require(<%=":#{class_name.split(':').last.downcase}"%>).permit!            
      <%- end -%>          
    end
    
    #def search_col
      #<%= class_name %>.column_names[1]
    #end     
end
<% end -%>
