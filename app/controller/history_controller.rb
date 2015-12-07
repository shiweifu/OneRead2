class HistoryCell < SSBaseTableCell

  def self.cellStyle
    UITableViewCellStyleDefault
  end

end

class HistoryController < UITableViewController

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


  def viewDidLoad
    @items = object_from_cache(:history)
    @items = @items.map { | json_obj |
      Item.new json_obj
    }

    @data_source = SSArrayDataSource.alloc.initWithItems(@items)
    @data_source.cellConfigureBlock = lambda { | cell, it, parent_view, index_path |
      t = it.name
      # t = date_to_str(it.access_date, '[M-dd]') + ' ' + t
      cell.textLabel.text = t
    }

    @data_source.tableActionBlock = lambda {|at, pv, ip| false }
    @data_source.cellClass = HistoryCell

    @data_source.tableView = self.tableView
    tableView.dataSource = @data_source

    self.title = '历史'

    menu_bar_item = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed("menu"), style:UIBarButtonItemStylePlain, target:self.revealViewController, action:'revealToggle:')
    # clear_bar_item = UIBarButtonItem.alloc.initWithTitle('清除', style:UIBarButtonItemStylePlain, target:self.revealViewController, action:'revealToggle:')

    clear_bar_item = UIBarButtonItem.titled('清除') do

      UIAlertView.alert('确认清除历史记录？',
                        message: '',
                        buttons: ['取消', '确认'],
      ) do |button, button_index|
        if button == '确认'  # or: button_index == 1
          remove_key(:history)
          @data_source.clearItems
          tableView.reloadData
        end
      end

    end


    self.navigationItem.leftBarButtonItem  = menu_bar_item
    self.navigationItem.rightBarButtonItem = clear_bar_item

  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    p "didSelect"

    tableView.deselectRowAtIndexPath(indexPath, animated:true)

    it = @data_source.itemAtIndexPath(indexPath)
    p "-----it", it
    rc = ReadController.new
    rc.item = it
    navigationController.pushViewController(rc, animated:true)
  end

end
