class StartController < UITableViewController

  def viewDidLoad
    menu_item = UIBarButtonItem.imaged(:menu.uiimage) do
      p "load menu icon"
      self.revealViewController.revealToggle(nil)
    end

    self.navigationItem.leftBarButtonItem = menu_item
  end

end
