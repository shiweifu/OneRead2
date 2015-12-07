include Common

class ReadController < UIViewController

  attr_accessor :item
  attr_accessor :params

  def viewDidLoad
    @web_view = UIWebView.nw
    @web_view.setBackgroundColor(UIColor.whiteColor)
    view.addSubview(@web_view)
    @web_view.delegate = self
    @web_view.pin_to_superview
    self.title = self.title_text
    load_data

    action_item = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAction, target:self, action:"on_action:")
    pocket_item = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action:"on_save:")

    self.navigationItem.setRightBarButtonItems([action_item, pocket_item])
  end


  def webView(webView, shouldStartLoadWithRequest: request, navigationType: navigationType)
    url = request.URL.absoluteString
    components = NSURLComponents.componentsWithString(url)
    if components.scheme == "image"
      img_path = "http:#{components.path}"
      # msg(img_path)
      # 1.second.later do
      #   hide_msg
      self.open_image(img_path)
      # end
    elsif components.scheme == "url"
      if components.path == ""
        false
      end
      full_url = "http:#{components.path}"
      UIActionSheet.alert('选择操作', buttons: ['取消', '保存到Pocket', '打开链接']
      ) do |button|
        self.save_to_pocket(full_url) if button == '保存到Pocket'
        self.open_url(full_url) if button  == '打开链接'
      end
    end
    true
  end

  def webViewDidFinishLoad(webView)
    hide_msg
  end

  def load_data
    req = self.link.nsurl.nsurlrequest
    @web_view.loadRequest(req)
  end

  def url
    @item.link
  end

  def link
    @item.link
  end

  def model_id
    @item.model_id
  end

  def title_text
    @item.name
  end

  def on_action(sender)
    UIActionSheet.alert('选择操作', buttons: ['取消', nil, '分享给微信好友', '分享到微信朋友圈', '跳转网页']
    ) do |button|
      self.share_to_wx_friend if button == '分享给微信好友'
      self.share_to_wx_group  if button == '分享到微信朋友圈'
      self.jump_to_web        if button == '跳转网页'
    end
  end

  def on_save(sender)
      UIActionSheet.alert('选择操作', buttons: ['取消', nil, '保存到Pocket']
    ) do |button|
      self.save_to_pocket link   if button == '保存到Pocket'
    end
  end

  def share_to_wx_friend
    m = OSMessage.new
    m.title = ''
    m.desc  = title_text
    m.link  = link
    m.image="Icon-60".uiimage.nsdata

    share_success = lambda {  | m | 
      msg('分享成功', type=:success)
    }

    share_failure = lambda {  | m, e | 
      msg('分享失败', type=:failure)
    }

    OpenShare.shareToWeixinSession(m, Success:share_success, Fail:share_failure)
  end

  def share_to_wx_group

    m = OSMessage.new
    m.title = ''
    m.desc  = title_text
    m.link  = link
    m.image="Icon-60".uiimage.nsdata


    share_success = lambda {  | m | 
      msg('分享成功', type=:success)
    }

    share_failure = lambda {  | m, e | 
      msg('分享失败', type=:failure)
    }

    OpenShare.shareToWeixinTimeline(m, Success:share_success, Fail:share_failure)

  end

  def jump_to_web
    url = self.link
    url.nsurl.open
  end


##############################################################################################
# action
##############################################################################################

  def save_to_evernote(src)
    
  end

  def save_to_pocket(src)
    access_token = NSUserDefaults[:pocket_access_token]

    puts("pocket access_token: #{access_token}")
    p "----src: #{src}"

    if access_token
      params = {"url"          => src,
                "consumer_key" => Define::POCKET_CONSUMER_KEY,
                "access_token" => access_token}
      p "---params: #{params}"
      Http.post_form("https://getpocket.com/v3/add", params) do | s |
        p "---add to pocket: #{s}"
        msg("已保存到Pocket", type=:success)
      end
    else
      params = {"consumer_key" => Define::POCKET_CONSUMER_KEY, "redirect_uri" => "pocketapp5678:authorizationFinished"}
      Http.post_form("https://getpocket.com/v3/oauth/request", params) do | s |
        s = s.nsstring
        print(s.class)
        code = s.split("=")[1]
        NSUserDefaults[:pocket_code] = code
        url  = "https://getpocket.com/auth/authorize?request_token=#{code}&redirect_uri=pocketapp5678:authorizationFinished"
        puts("auth url:#{url}")
        url.nsurl.open
      end
    end
  end

  def open_url(src)
    wvc = SVModalWebViewController.alloc.initWithAddress(src)
    self.presentViewController(wvc, animated:true, completion:nil)
  end

  def open_image(src)
    MotionImager.new({
      url: src,
      placeholder: 'placeholder',
      presenting_from: WeakRef.new(self),
    }).show
  end
end
