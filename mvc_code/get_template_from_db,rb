module CrudHelper
  VIEW_DIR  = 'selfed'
  VIEW_LIST = Dir.entries( File.join(Rails.root, 'app/views', VIEW_DIR)).
    reject { |f| File.directory? f }.
    map{|f|  File.basename( f, ".html.erb" )}

  def map_action(act)
    case act
    when 'create' then act = 'new'
    when 'update' then act = 'edit'
    end
    act
  end

  def my_template(
    act = get_action_name,
    ns  = get_controller_namespace,
    ctl = get_controller_name,
    opt = get_scope
  )
    return @template unless @template.blank?
    act = map_action(act)
    "shared/#{act}" #shared/[index,new,edit]
  end

  # Serach from self directory
  # fall back if not found
  # Need revise to support Rails.root
  # 2018/9/30
  def my_template_self_directory(
    act = get_action_name,
    ns  = get_controller_namespace,
    ctl = get_controller_name,
    opt = get_scope
  )
    # try order for index
    #   _ns.ctrl.action.opt
    #   _ns.ctrl.action
    #  shared/action
    # try order for edit/new
    #   _ns.ctrl.action.opt
    #   _ns.ctrl.action
    #   _ns.ctrl.form.opt
    #   _ns.ctrl.form
    #   shared/action
    # try order for create/update
    #   create => new
    #   update => edit
    #   follow the above pattern
    act = map_action(act)
    acts = [ act ]
    acts << 'form' if %w(edit new).include?(act)
    acts.each do |actx|
      unless opt.blank?
        vname= view_name(actx, ctl, ns, opt)
        return "#{VIEW_DIR}/#{vname}" if VIEW_LIST.include?(vname)
      end
      vname= view_name(actx, ctl, ns, nil)
      return "#{VIEW_DIR}/#{vname}" if VIEW_LIST.include?(vname)
    end
    "shared/#{act}" #shared/[index,new,edit]
  end

  def view_name(action, controller, controller_namespace, scope)
    # action: index, edit, new, form,
    # so should not use action_name
    fname_parts = [ controller_namespace, controller, action, scope ]
    fname = fname_parts.select{|x| x.to_s!="" }.join('.')
    "_#{fname}"
  end
end
