describe '测试公众号源' do

  before do
    @rss_test = 'http://www.hi-pda.com/forum/rss.php?fid=2&auth=614fraJZUi3pNmeDRdhFmKEHcy%2B6rz82xnfs3Rug7G1VjpOnclRfyxSgDR%2B6Ew'
    @rss_source = RSSSource.build({name: "hi-pda", url: @rss_test})
    @items = []
  end

  it 'test RSS Source' do
    @rss_source.load_router do | b |
    end

    @rss_source.items_with_page(1) do | items |
      @items = items
    end

    wait 3 do
      (@items.empty?).should.not == true
      (@items.first.instance_of? Item).should.be == true
    end

  end

end
