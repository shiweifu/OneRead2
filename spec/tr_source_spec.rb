describe '测试十阅的源' do

  before do

    @source = TRSource.build({base_url: 'http://www.jianshu.com',
                                   url: 'http://www.jianshu.com/trending/now',
                              selector: 'h4>a',
                                  name: '简书'})
  end

  it 'test tenread source' do

    @source.load_router do | b |
    end

    wait 3 do
      @source.items_with_page 0 do | its |
        @items = its
      end
    end

    wait 5 do
      @source.is_loaded.should.be == true
      (@items.empty?).should.not == true
      (@items.first.instance_of? Item).should.be == true
    end
  end

end
