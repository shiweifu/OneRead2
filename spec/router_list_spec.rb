
describe '测试源列表' do


  before do

    @zhihu_url  = 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/zhihu.r'
    @sf_url     = 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/sf.r'
    @mono_url   = 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/mono.r'
    @dgtle_url  = 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/dgtle.r'
    @js_content = ""
    @js_obj     = nil
    @items      = []

  end

  # it 'SegmentFault' do
  #   true.should == false
  # end
  #
  # it 'Zhihu' do
  #
  #   true.should == false
  # end

  it 'Dgtle' do
    @js_obj = JSSource.build({url: @dgtle_url, name: "Dgtle"})
    @is_loaded = false
    @js_obj.load_router do | is_loaded |
      @is_loaded = is_loaded
    end

    wait 3 do
      @is_loaded.should == true
      p "here"

      @js_obj.items_with_page(1) do | items |
        SpecHelper::sp("items", items)
        (items.empty?).should.not == true
        (items.first.instance_of? Item).should.be == true
        items.first.link.should.not.equal ""
        items.first.name.should.not.equal ""
        items.first.id.should.not.equal ""
        @item = items.first

        url = @js_obj.url_with_model(@item)
        url.should.not.equal ""
      end

      wait 3 do

      end

    end


  end

  it 'Mono' do

    @js_obj = JSSource.build({url: @mono_url, name: "Mono"})
    @is_loaded = false
    @js_obj.load_router do | is_loaded |
      @is_loaded = is_loaded
    end

    wait 3 do
      @is_loaded.should == true
      p "here"

      @js_obj.items_with_page(1) do | items |
        SpecHelper::sp("items", items)
        (items.empty?).should.not == true
        (items.first.instance_of? Item).should.be == true
        items.first.link.should.not.equal ""
        items.first.name.should.not.equal ""
        items.first.id.should.not.equal ""
        @item = items.first

        url = @js_obj.url_with_model(@item)
        url.should.not.equal ""
      end

      wait 3 do

      end

    end

  end
end