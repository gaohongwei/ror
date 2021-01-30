module ApplicationHelperOld
	def get_columns(opt=nil)
		columns=get_cfg4key(:cols,opt)
		logger.debug "columns"	
		logger.debug columns
		columns
	end
	def get_captions(opt=nil)
		caps=get_cfg4key(:caps,opt)
		caps || get_columns(opt)
	end	
	def get_all_by_key(key)
		if key == :cols || key == :caps
			return get_all_cols
		end
		if key == :acts
			return get_all_acts			
		end
		nil
	end	
	def get_all_cols(controller=nil)
		controller ||=get_controller
		cols=controller.classify.constantize.column_names
		cols.delete("id")
		cols.delete("created_at")
		cols.delete("updated_at")		
		cols
	end

	def get_cfg4key(key,opt=nil)
		cfg=get_cfg4act
		dft_value=get_all_by_key(key)
		if cfg.nil?
			return dft_value
		end
		opt ||=get_scope()
		opt ||=:dft
		opt =opt.to_sym		
		if  cfg[opt].nil? || cfg[opt].empty?
			return cfg[key]	||	dft_value	
		end
		cfg=cfg[opt]		
		cfg[key] || dft_value
	end	
	def get_actions(action=nil,controller=nil,id=nil)
    action ||= get_action		
		controller ||= get_controller	
		id ||=get_id()
		cfg=VIEWS[controller.to_sym]
		acts=nil
		if  cfg.nil? || cfg.empty? ||
				cfg[:acts].nil? || cfg[:acts].empty?
			acts = ACTS.dup
		else
			acts = cfg[:acts].dup
		end			
		#if(id.nil?) #index,new
		if(['index','new'].include?(action))
			acts.delete_if {|w|w=~/^edit/}
			acts.delete_if {|w|w=~/^show/}
			acts.delete_if {|w|w=~/^copy/}						
		end
		# Delete current one

		action ||=get_action	
		opt=get_scope()		
		unless opt.nil?
			action="#{action}:#{opt}"
		end
		#acts.delete(action)	
		acts.delete(action)
		acts
	end	
	def get_cfg4act(action=nil,controller=nil)	
		controller ||= get_controller
		action ||=get_action
		action =('new' == action)? 'edit' : action
		ctl=controller.to_sym
		act=action.to_sym
		cfg=VIEWS[ctl]
		if  cfg.nil? 		
			return nil
		end
		cfg=cfg[act]
	end		
end