# 这里面直接调用网络接口

class OneStore
  DAILY_LIST_URL = 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/list'
  DAILY_SOURCE_BASE_URL = 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/'

  def self.daily_source_list(&callback)
    Http.get_json(DAILY_LIST_URL, {}) do | result |
      source_list = result.map { | d |
        display_name = d[:name]
        source_path  = d[:router_name]
        url = "#{DAILY_SOURCE_BASE_URL}#{source_path}"
        s = {url: url, name: display_name}
        JSSource.build s
      }
      callback.call source_list
    end
  end

  def self.rss_source_list(&callback)

  end


end
