
# 从Coding上拉下来的JSSource通过这个类进行生成

class JSSource

  CELL_CLASS  = BasicCell

  attr_reader :display_name

  def initialize(opts  =  {})
    @url               = opts[:url]
    @display_name      = opts[:name]
    @router_class_name = 'Router'
    @is_loaded = false

  end

  def load_router(&callback)
    Http.get_string(@url, {}) do | result |
      if result
        @js_context = JSContext.alloc.init
        @js_context.evaluateScript(result)
        @is_loaded = true
        callback(true)
      else
        callback(false)
      end
    end
  end

  def context_router
    unless @context_router
      @context_router = @js_context[@router_class_name]
    end
    @context_router
  end

  def self.build(opts = {})

    unless opts.has_key? :name or opts.has_key? :js_content
      raise ArgumentError.new('name and js_content should be set')
    end

    m = JSSource.new(opts)
    return m
  end

  def path
    "/list"
  end

  def url_with_model(m)
    detail_url_func = @context_router["detail_url"]
    p "###m: #{m}"
    p "###m json: #{m.to_json}"
    url_value       = detail_url_func.callWithArguments([m.to_json])
    result          = url_value.toString
    result
  end

  def cell_config_action
    l = lambda { |cell, object, parent_view, index_path|
      cell.model = object
    }
    l
  end

  def items_from_json(json_str)
    func = @context_router["items_from_json"]
    result = func.callWithArguments([json_str])
    items_str  = result.toString
    items_hash = BW::JSON.parse(items_str)
    items = items_hash.map { | m | Item.new m}
  end

  def page_url(p)
    func = @context_router["page_url"]
    result = func.callWithArguments([p])
    result.toString
  end

  def detail_url(detail_url)
    func = @context_router["page_url"]
    result = func.callWithArguments([detail_url])
    result.toString
  end

end

