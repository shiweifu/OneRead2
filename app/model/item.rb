class Item
  attr_accessor :id, :name, :time, :created_date, :excerpt, :tags, :link, :images, :access_date

  def initialize(json={})
    @id           = json[:id].to_s
    @name         = json[:title] || json[:name]
    @time         = json[:votes]
    @excerpt      = json[:excerpt]
    @tags         = json[:tags]
    @created_date = json[:createdDate]
    @link         = json[:link] || json[:url] || json[:original_url]
    @images       = json[:images]
    # 冗余的属性,用来标示history中的访问时间
    @access_date  = json[:access_date]
  end

  def to_json
    result = {         id: @id,
                     name: @name,
                     time: @time,
                  excerpt: @excerpt,
                     tags: @tags,
             created_date: @created_date,
                     link: @link,
              access_date: NSDate.new.timeIntervalSince1970.to_s,
                   images: @images}

    BW::JSON.generate(result)
  end

  def to_hash
    result = {         id: @id,
                       name: @name,
                       time: @time,
                       excerpt: @excerpt,
                       tags: @tags,
                       created_date: @created_date,
                       link: @link,
                       access_date: NSDate.new,
                       images: @images}
  end
end