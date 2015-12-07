include Common

class MenuController < UITableViewController

  TOP_CELL_HEIGHT = 64.5

  def viewDidLoad
    self.tableView.setTableFooterView(UIView.new)

    "article_source_changed".add_observer(self, "on_source_changed")

    refresh
  end

  def on_source_changed
    refresh
  end

  def dealloc
    "article_source_changed".remove_observer(self)
  end

  def refresh
    @ds = SSArrayDataSource.alloc.initWithItems(menu_items)
    @ds.tableView = self.tableView
    @ds.tableActionBlock = lambda {|at, pv, ip| false }
    @ds.cellConfigureBlock = lambda do | cell, obj, parentview, indexPath |

      if indexPath.row == 0
        # 第一行
        cell.selectionStyle = UITableViewCellSelectionStyleNone
        cell.textLabel.text = ""
      elsif indexPath.row == menu_items.size - 1 || indexPath.row == menu_items.size - 2
        # 设置和历史
        cell.textLabel.text = obj
      else
        # 源，显示名字
        cell.textLabel.text = obj.display_name
      end
    end
  end

  def tableView(tv, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated:true)
    if indexPath.row == 0

    elsif indexPath.row == menu_items.count - 1
      # 设置
      c = find_router "/setting"
      present_controller c
    elsif indexPath.row == menu_items.count - 2
      # 历史
      history_controller = find_router("/history", dic={})
      open_controller history_controller
    else
      c = ListController.new
      c.source = menu_items[indexPath.row]
      p "----c.source: #{c.source}"
      open_controller c
    end
  end


  def menu_items
    items = Config.menu_items
    items.concat(["历史", "设置"])
    items = [""].concat(items)
    items
  end

end
