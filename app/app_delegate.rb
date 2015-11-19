class AppDelegate

  attr_accessor :revealController

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
    # AVOSCloud.setApplicationId("hOcyOHJhkNTC3V5pU2f2tnyx", clientKey:"iYE2opHhq36VMK99rTho8J8b")
    OpenShare.connectWeixinWithAppId("wxb89d2a6ca7643c4f")
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
