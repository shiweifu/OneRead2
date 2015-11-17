describe '测试日报类源' do

  before do
    @list = []

    url  = 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/zhihu.r'
    name = '知乎日报'
    @js_obj = JSSource.build({url: url, name: name})
  end

  it 'get daily source list' do
    OneStore.daily_source_list do | result |
      @list = result
    end

    wait 3 do
      SpecHelper::sp('@list', @list)
      @list.size.should.not.be == 0
      (@list.first.instance_of? JSSource).should.be == true
    end
  end

  it 'daily source load' do

    (@js_obj.instance_of? JSSource).should.be == true

    @js_obj.load_router do | v |
      v.should.be == true
    end

    wait 1 do
      @js_obj.is_loaded.should.be == true
      @js_obj.path.should.equal "/list"
      url = @js_obj.page_url 0
      url.should.not.equal ""
      json_str = Http.get_url url
      items = @js_obj.items_from_json json_str
      (items.empty?).should.not == true
      (items.first.instance_of? Item).should.be == true
      i = items.first
      model_url = @js_obj.url_with_model i
      model_url.should.not.equal ""
    end
  end

end
