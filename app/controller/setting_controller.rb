class SettingController < UITableViewController

  include Router
  include Common

  def viewDidLoad
    @titles = [['关于', '分享给朋友', '去AppStore打分'], ['反馈']]

    self.title = '设置'

    c = UIBarButtonItem.titled('关闭') do
      self.dismissViewControllerAnimated(true, completion:nil)
    end

    self.navigationItem.leftBarButtonItem = c

    r = UIBarButtonItem.titled('选择源') do
      s   = find_router('/source', dic={})
      nav = UINavigationController.alloc.initWithRootViewController(s)
      self.presentViewController(nav, animated:true, completion:nil)
    end

    self.navigationItem.rightBarButtonItem = r
    self.tableView.setTableFooterView(UIView.new);
  end

  def numberOfSectionsInTableView(table_view)
    @titles.count
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @titles[section].count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    44
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)

    t = @titles[indexPath.section][indexPath.row]
    c = UITableViewCell.default('cell_identifier',
                                accessory: :disclosure.uitablecellaccessory,
                                selection: :blue.uitablecellselectionstyle,
                                text: t,
                                image: '', )

    c
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)

    tableView.deselectRowAtIndexPath(indexPath, animated:true)

    if indexPath.section == 1 && indexPath.row == 0
      # 反馈
      feedbackViewController = LCUserFeedbackViewController.alloc.init
      feedbackViewController.feedbackTitle = nil
      feedbackViewController.contact = nil
      feedbackViewController.contactHeaderHidden = true
      feedbackViewController.presented = true
      feedbackViewController.navigationBarStyle = LCUserFeedbackNavigationBarStyleNone
      present_controller feedbackViewController
    elsif indexPath.section == 0 && indexPath.row == 0
      # 关于
      controller = find_router("/about", {"title" => "关于"})
      self.navigationController.pushViewController(controller, animated:true)
    elsif indexPath.section == 0 && indexPath.row == 1
      # 分享给朋友
      m = OSMessage.new
      m.title = ''
      m.desc  = '试试这个阅读应用吧'
      m.link  = Config::APP_URL
      m.image="Icon-60".uiimage.nsdata

      share_success = lambda {  | m |
        msg('谢谢您', type=:success)
      }

      share_failure = lambda {  | m, e |
        msg('莫名的失败', type=:failure)
      }

      OpenShare.shareToWeixinSession(m, Success:share_success, Fail:share_failure)

    elsif indexPath.section == 0 && indexPath.row == 2
      # 去appstore 打分
      UIApplication.sharedApplication.openURL(NSURL.URLWithString(Config::APP_REVIEW_URL))
    end
  end

  def mailComposeController(controller, didFinishWithResult:result, error:err)
    if result == MFMailComposeResultSent
      msg("发送成功", type=:success)
    end
    self.dismissViewControllerAnimated(true, completion:nil)
  end

end
