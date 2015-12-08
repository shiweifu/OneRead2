module Config

  APP_DAILY_SOURCE_LIST_URL    = "https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/list"
  APP_DAILY_SOURCE_BASE_URL    = "https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/"
  APP_RSS_SOURCE_LIST_URL      = "https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/rss_list"
  APP_TEN_READ_SOURCE_LIST_URL = "https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/ten_read_list"

  APP_URL              = "http://itunes.apple.com/app/id1032943622"
  APP_REVIEW_URL       = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1032943622"


  def Config.menu_items
    daily_list    = Common::object_from_cache(:daily_list)    || []
    rss_list      = Common::object_from_cache(:rss_list)      || []
    ten_read_list = Common::object_from_cache(:ten_read_list) || []

    daily_list    = [].concat daily_list
    rss_list      = [].concat rss_list
    ten_read_list = [].concat ten_read_list

    if daily_list.empty? and rss_list.empty? and rss_list.empty?
      daily_list << {url: 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/zhihu.r', name: '知乎日报'}
      daily_list << {url: 'https://coding.net/u/shiweifu/p/OneReadRouter/git/raw/master/sf.r', name: 'SegmentFault'}

      rss_list   << {name: "槽边往事", url:  'http://rss.catcoder.com/rss/26-b1a7b2a5407db7e0fa98f8c6e12f92a4594'}
      rss_list   << {name: "MacTalk", url: 'http://rss.catcoder.com/rss/1-b1a7b2a5407db7e0fa98f8c6e12f92a4594'}

      ten_read_list << {base_url: 'http://www.jianshu.com',   url: 'http://www.jianshu.com/trending/now', selector: 'h4>a',     name: '简书'}
      ten_read_list << {base_url: 'http://news.dbanotes.net', url: 'http://news.dbanotes.net',            selector: '.title>a', name: 'Startup News'}
    end

    daily_list = daily_list.map { |m|
      JSSource.build m
    }

    rss_list = rss_list.map { |r|
      RSSSource.build r
    }

    ten_read_list = ten_read_list.map { | m |
      TRSource.build m
    }

    result = []
    result.concat daily_list
    result.concat rss_list
    result.concat ten_read_list

    result
  end

end

