describe "网络访问测试" do

  before do

    @string_url = 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/sf.r'
    @json_url   = 'http://api.segmentfault.com/config/show'
    @body = ''
    @body_hash = {}

  end

  it 'get string from url' do

    Http::get_string(@string_url, {}) do | result |
      @body = result
    end

    wait 1 do
      @body.should.not == ""
      @body.class.should.equal String
    end
  end

  it  'get json from url' do

    [].should.be.empty
    Http::get_json(@json_url, {}) do | result |
      @body_hash = result
    end

    wait 1 do
      @body_hash.class.should.equal Hash
    end

  end

end
