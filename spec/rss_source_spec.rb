describe '测试公众号源' do

  before do
    @rss_test = 'http://weirss.me/account/bitsea/feed/'
    @rss_source = RSSSource.build({name: "Caobianwangshi", url: @rss_test})
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
