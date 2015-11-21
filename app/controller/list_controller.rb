include Common
include Router

class ListController < UITableViewController

  attr_accessor :source

  def viewDidLoad
    self.title = @source.display_name

    if source.instance_of? JSSource
      @dds = DailyDataSource.build({source: source})

      @ds = SSArrayDataSource.alloc.initWithItems([])
      @ds.tableView = self.tableView
      @ds.tableActionBlock = lambda {|at, pv, ip| false }
      @ds.cellConfigureBlock = lambda do | cell, obj, parentview, indexPath |
        cell.textLabel.text = obj.name
      end

      refresh
    else
      msg "加载错误"
    end

    setup_nav_bar_items

  end

  def setup_nav_bar_items

    menu_item = UIBarButtonItem.imaged(:menu.uiimage) do
      p "load menu icon"
      self.revealViewController.revealToggle(nil)
    end

    self.navigationItem.leftBarButtonItem = menu_item

    refresh_item = UIBarButtonItem.imaged(:refresh.uiimage) do
      refresh
    end

    next_item = UIBarButtonItem.imaged(:next.uiimage) do
      next_page
    end

    back_item = UIBarButtonItem.imaged(:back.uiimage) do
      back_page
    end

    right_bar_button_items = [next_item, back_item, refresh_item]

    self.navigationItem.rightBarButtonItems = right_bar_button_items
  end


  def refresh
    @page = 1
    @dds.page = @page
    reload_items
  end

  def reload_items
    @dds.page = @page

    msg("正在加载..")

    @dds.items do | its |
      @ds.clearItems
      @ds.appendItems its
      hide_msg
      tableView.reloadData
    end
  end

  def next_page
    @page += 1
    @dds.page = @page
    reload_items
  end

  def back_page
    @page -= 1
    if @page < 1
      @page = 1
    end
    @dds.page = @page
    reload_items
  end

  def tableView(tv, didSelectRowAtIndexPath: indexPath)
    p "didSelect"

    it = @ds.itemAtIndexPath(indexPath)
    p "-----it", it

    rc = ReadController.new
    rc.item = it
    navigationController.pushViewController(rc, animated:true)
  end

end
