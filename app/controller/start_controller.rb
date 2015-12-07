class StartController < UITableViewController

  def viewDidLoad
    menu_item = UIBarButtonItem.imaged(:menu.uiimage) do
      p "load menu icon"
      self.revealViewController.revealToggle(nil)
    end

    self.navigationItem.leftBarButtonItem = menu_item
  end

  def viewWillAppear(animated)
    revealController = self.revealViewController
    self.navigationController.view.addGestureRecognizer(revealController.panGestureRecognizer)
    self.navigationController.view.addGestureRecognizer(revealController.tapGestureRecognizer)
  end

  def viewWillDisappear(animated)
    revealController = self.revealViewController
    self.navigationController.view.removeGestureRecognizer(revealController.panGestureRecognizer)
    self.navigationController.view.removeGestureRecognizer(revealController.tapGestureRecognizer)
  end

end
