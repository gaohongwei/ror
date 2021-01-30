module ApplicationHelper
	ACTS=['show','edit','index','new','copy'] 	
	#Use instance variable to avoid repeative database access
	def get_columns()	
		cfg=get_columns_captions('cols')
		params[:cols]=cfg.join(',')
		cfg
	end
	def get_captions() 
		cfg=get_columns_captions('caps')		 
	end	
	def get_actions(action=nil,controller=nil,id=nil)
    action ||= get_action		
		id ||=get_id()
		acts=get_actions_all(controller)
		acts=get_actions_useful(acts)
		params[:acts]=acts.join(',')
		acts
	end	
	def get_columns_captions(column_name) # caps or cols 
		cfg=get_cfg_by_action()
		if cfg.nil? || cfg.size <1
			columns =get_all_cols()			
		else
			cfg = cfg[0][column_name]
			if cfg.nil? || cfg.empty?
				columns =get_all_cols()
			else
				#columns = cfg.split(/[;,]/) #split(';\s')	
				columns = cfg.split(';') #split(';\s')	
			end	
		end
		columns
	end

###################### Tools ######################
	def get_cfg_by_action(controller=nil,action=nil,scope=nil)
    action ||= get_action		
		scope  ||= get_scope	
		action ='edit' if action =='create' || action=='update'
		action_scope=(scope.nil?||scope.empty?)? action: (action+':'+scope)	
		if action_scope =='new'
			cfg=get_cfg_by_controller(controller).by_action(action_scope)
			if cfg.nil?||cfg.empty?
				action_scope='edit'
				cfg=get_cfg_by_controller(controller).by_action(action_scope)
			end
		else 
			cfg=get_cfg_by_controller(controller).by_action(action_scope)			
		end
		#params[action_scope]=cfg
		cfg
	end	
	def get_cfg_by_controller(controller=nil)	
		controller ||= get_controller().singularize			
		@cfg_by_controller=ViewAdm.by_controller(controller)
	end		

	def get_actions_useful(acts=nil,action=nil,controller=nil,id=nil)
		action ||=get_action			
		#if(id.nil?) #index,new	
		if(['index','new'].include?(action))
			acts.delete_if {|w|w=~/^edit/}
			acts.delete_if {|w|w=~/^show/}
			acts.delete_if {|w|w=~/^copy/}
			# delete actions starting with these						
		end

		# Skip false action
		#  new:false,edit:false etc
		ACTS.each do |act|		
			if acts.delete("#{act}:false")
				acts.delete(act)
			end	
		end	
		
		# Skip current action with scope
		# Delete current one with scope
		opt=get_scope()		
		unless opt.nil?
			action="#{action}:#{opt}"
		end
		# Delete current one with scope
		acts.delete(action)			
		acts
	end	
	def get_actions_all(controller)
		return @actions_all if @actions_all 

		cfg=get_cfg_by_controller(controller)
		if  cfg.nil? || cfg.empty?
			acts = ACTS.dup		
		else		
			acts =cfg.map{|x|x.action_scope}
			acts.concat(ACTS)
			acts=acts.uniq				
		end
		#params[:acts_all]=acts.join(';')	
		@actions_all=acts
	end	

	def get_all_cols(controller=nil)
		controller ||=get_controller
		cols=controller.classify.constantize.column_names
		cols.delete("id")
		cols.delete("created_at")
		cols.delete("updated_at")		
		cols
	end		
end