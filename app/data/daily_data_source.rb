# 得到所有的日报类源，并作为TableView的DataSource来使用

class DailyDataSource < SSArrayDataSource

  attr_accessor :page

  def initialize(params)
    @source = params[:source]
    @page = 1
  end

  def items(&cb)
    @source.load_router do | a |
      if a
        # 加载页面
        @source.items_with_page(@page) do | items |
          if items
            cb.call(items)
          else
            cb.call([])
          end
        end
      else
        cb.call([])
      end
    end
  end

  def self.build(opts={})

    unless opts.has_key? :source
      raise ArgumentError.new('source should not set')
    end

    DailyDataSource.new opts

  end

end

