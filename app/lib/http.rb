module Http

  def Http.get_string(url, params, &callback)
    AFMotion::HTTP.get(url, params=params) do |result|
      callback.call(result.body)
    end
  end

  def Http.get_json(url, params, &callback)
    AFMotion::JSON.get(url, params=params) do |result|
      r = BW::JSON.parse result.body
      callback.call(r)
    end
  end

  def post_json(url, params, &callback)
    AFMotion::JSON.post(url, params=params) do |result|
      callback.call(result.object)
    end
  end

  def Http.post_form(url, params, &callback)
    AFMotion::HTTP.post(url, params=params) do |result|
      callback.call(result.object)
    end
  end

  def Http.get_url(url)
    u = NSURL.alloc.initWithString(url)
    NSString.stringWithContentsOfURL(u)
  end

end