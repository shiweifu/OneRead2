include Common

class SourceController < UIViewController

  def viewDidLoad

    self.view.backgroundColor = :white.uicolor

    self.view.addSubview(self.table_view)
    self.table_view.pin_to_superview
    self.table_view.delegate = self

    # 已经选择了的源

    self.navigationItem.titleView = self.segmented_control

    right_item = UIBarButtonItem.done do
      cache_object(@rss_list,   :rss_list)
      cache_object(@daily_list, :daily_list)

      # 确保缓存已经写入
      "article_source_changed".post_notification

      self.dismissViewControllerAnimated(true, completion:nil)
    end

    left_item = UIBarButtonItem.cancel do
      self.dismissViewControllerAnimated(true, completion:nil)
    end

    self.navigationItem.rightBarButtonItem = right_item
    self.navigationItem.leftBarButtonItem  = left_item

    self.table_view.setTableFooterView(UIView.new)

    setup_data_source

    self.segmented_control.selectedSegmentIndex = 0
    self.segmented_control.sendActionsForControlEvents(UIControlEventValueChanged)

    @daily_list = Common::object_from_cache(:daily_list) || []
    @rss_list   = Common::object_from_cache(:rss_list)   || []

    @daily_list = [].concat @daily_list
    @rss_list   = [].concat @rss_list

  end

  def setup_data_source
    @data_source = SSArrayDataSource.alloc.initWithItems([])
    @data_source.tableView = self.table_view
    @data_source.cellConfigureBlock = lambda { |cell, object, parent_view, index_path|
      cell.textLabel.text = object.display_name
    }

    @data_source.cellCreationBlock = lambda { |object, parent_view, index_path|
      a = :none

       p "----object:#{object}"

      if segmented_control.selectedSegmentIndex == 0
        # Daily
        a = :checkmark unless @daily_list.select { |n| n[:name] == object.display_name }.empty?
      else
        # RSS
        a = :checkmark unless @rss_list.select { |n| n[:name] == object.display_name }.empty?
      end

      cell = UITableViewCell.default('cell_identifier',
                                     accessory: a,
                                     selection: :blue,
                                     text: '')
      cell
    }

    @data_source.tableActionBlock = lambda {|at, pv, ip| false }
    table_view.dataSource = @data_source
  end

  def table_view
    @table_view = UITableView.nw unless @table_view
    @table_view
  end

  def segmented_control
    unless @segmented_control
      @segmented_control = UISegmentedControl.bar(["日报", "RSS"])
      @segmented_control.addTarget(self, action:'on_segmented_control_change:', forControlEvents:UIControlEventValueChanged)
    end
    @segmented_control
  end

  # 上面的segmented按钮选择的时候，设置当前的tableView的dataSource
  def on_segmented_control_change(sender)
    # 选择日报的时候，需要刷新列表
    if sender.selectedSegmentIndex == 0
      refresh_daily_source
    else
    # 选择RSS的时候，不需要刷新列表
      refresh_rss_source
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated:true)

    s = @data_source.itemAtIndexPath indexPath
    h = {url: s.url, name: s.display_name}

    cell = tableView.cellForRowAtIndexPath(indexPath)
    if cell.accessoryType == UITableViewCellAccessoryCheckmark
      cell.accessoryType = UITableViewCellAccessoryNone

      if segmented_control.selectedSegmentIndex == 0
        # Daily
        @daily_list.delete_if { | it | it[:url] == h[:url] }
      else
        # RSS
        @rss_list.delete_if { | it | it[:url] == h[:url] }
      end
    else
      cell.accessoryType = UITableViewCellAccessoryCheckmark

      if segmented_control.selectedSegmentIndex == 0
        # Daily
        @daily_list << h
      else
        # RSS
        @rss_list   << h
      end
    end

  end

  def refresh_rss_source
    list_url    = Config::APP_RSS_SOURCE_LIST_URL
    @data_source.clearItems

    Http.get_string(list_url, {}) do  | items_str |
      @data_source.clearItems
      items = BW::JSON.parse(items_str)
      items = items.map { | it |
        url = it['url']
        h   = {name: it['name'], url: url}
        RSSSource.build(h)
      }
      @data_source.appendItems items
    end
  end

  # 从服务器上拉数据回来
  def refresh_daily_source
    list_url    = Config::APP_DAILY_SOURCE_LIST_URL
    @data_source.clearItems

    Http.get_string(list_url, {}) do  | items_str |
      @data_source.clearItems
      items = BW::JSON.parse(items_str)
      items = items.map { | it |
        url = Config::APP_DAILY_SOURCE_BASE_URL + it['router_name']
        h   = {name: it['name'], url: url}
        JSSource.build(h)
      }
      @data_source.appendItems items
    end
  end
end

