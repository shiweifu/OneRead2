class AppDelegate

  include Common
  include Define

  attr_accessor :revealController

  def application(app, openURL:url, sourceApplication:sa, annotation:ann)
    if (OpenShare.handleOpenURL(url))
      p "handle open share with url: #{url}"
      return true
    end

    if url.absoluteString == "pocketapp5678:authorizationFinished"
      puts("准备获取access_token")
      pocket_code = NSUserDefaults[:pocket_code]
      params = {"consumer_key" => Define::POCKET_CONSUMER_KEY, "code" => pocket_code}
      puts("auth params:#{params}")
      Http.post_form("https://getpocket.com/v3/oauth/authorize", params) do | result |
        p "----auth result: #{result}"
        result = result.nsstring
        access_token = result.split("=")[1].split("&")[0]
        NSUserDefaults[:pocket_access_token] = access_token
      end
    end

  end


  def application(application, didFinishLaunchingWithOptions:launchOptions)
    startController = StartController.new
    startController.view.backgroundColor = UIColor.whiteColor

    nav = UINavigationController.alloc.initWithRootViewController(startController)

    nav.navigationBar.alpha = 0

    menu_controller = MenuController.alloc.init

    @revealController = SWRevealViewController.alloc.initWithRearViewController(menu_controller,frontViewController:nav)

    @revealController.rearViewRevealWidth    = 150
    @revealController.rearViewRevealOverdraw = 0
    @revealController.frontViewShadowRadius  = 0.5
    @revealController.frontViewShadowColor   = :gray.uicolor

    c = EGOCache.globalCache
    i = 86400 * 30 * 12
    c.setDefaultTimeoutInterval(i)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = @revealController
    @window.makeKeyAndVisible

    setup_cloud
    setup_router
    true

  end

  def setup_cloud
    AVOSCloud.setApplicationId(AVCLOUD_ID, clientKey:AVCLOUD_KEY)
    OpenShare.connectWeixinWithAppId(WEIXIN_ID)
  end


  def setup_router
    register_router("/list") do | params |
      list = ListController.alloc.init
      list.params = params
      list
    end

    register_router("/about") do | params |
      list = AboutController.alloc.init
      list.params = params
      list
    end


    register_router("/history") do | params |
      list = HistoryController.alloc.init
      list.params = params
      list
    end

    register_router("/source") do | params |

      sc = SourceController.alloc.init
      sc.params = params
      sc
    end

    register_router("/read") do | params |
      rc = ReadController.alloc.init
      rc.params = params
      rc
    end

    register_router("/setting") do | params |
      rc = SettingController.alloc.initWithStyle(UITableViewStyleGrouped)
      rc.params = params
      rc
    end
  end
end
