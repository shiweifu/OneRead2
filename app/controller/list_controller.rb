include Common
include Router

class ListController < UITableViewController

  attr_accessor :source

  def viewDidLoad
    refresh
    self.title = @source.display_name
  end

  def refresh
    @page = 1

    msg("正在加载..")

    if source.instance_of? JSSource
      @dds = DailyDataSource.build({source: source})

      @ds = SSArrayDataSource.alloc.initWithItems([])
      @ds.tableView = self.tableView
      @ds.tableActionBlock = lambda {|at, pv, ip| false }
      @ds.cellConfigureBlock = lambda do | cell, obj, parentview, indexPath |
        cell.textLabel.text = obj.name
      end

      hide_msg

      reload_items
    else
      hide_msg
    end

  end

  def reload_items

    @dds.items do | its |
      @ds.clearItems
      @ds.appendItems its
      tableView.reloadData
    end

  end

  def next
    @page += 1
    @dds.page = @page
    reload_items
  end

  def back
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

    # url = "/read"
    # params = {"title" => it.name, "type" => "", "model_id" => it.id, "link" => it.link}
    # p '----read params:', params
    # rc = find_router(url, {params: params})
    # p "----", rc
    rc = ReadController.new
    rc.item = it
    navigationController.pushViewController(rc, animated:true)
  end

end
