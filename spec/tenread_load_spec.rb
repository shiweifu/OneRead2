describe '测试加载十阅的源' do

  before do
    @list_url         = 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/ten_read_list'

    @hacker_news      = 'https://news.ycombinator.com/'
    @hacker_news_selector = '.title>a'

    @jianshu_url      = 'http://www.jianshu.com/trending/now'
    @jianshu_selector = 'h4>a'
    @jianshu_base_url = 'http://www.jianshu.com'
  end

  it 'load tenread list' do
    @body_hash = []

    Http::get_json(@list_url, {}) do | result |
      @body_hash = result
    end

    wait 1 do
      @body_hash.class.should.equal Array
      (@body_hash.empty?).should.not == true
    end

  end

  it 'parse html' do
    @result = []

    Http::get_string(@jianshu_url, {}) do | html |
      document = HTMLDocument.documentWithString html
      list = document.nodesMatchingSelector(@jianshu_selector)
      @result = list.map { | r |
        {name: r.textContent, link: @jianshu_base_url + r.attributes['href']}
      }
    end

    wait 5 do
      @result.class.should.equal Array
      (@result.empty?).should.not == true
      p @result.to_s
    end
  end

end
