class Item
  attr_accessor :id, :name, :time, :created_date, :excerpt, :tags, :link, :images

  def initialize(json={})
    @id           = json[:id]
    @name         = json[:title] || json[:name]
    @time         = json[:votes]
    @excerpt      = json[:excerpt]
    @tags         = json[:tags]
    @created_date = json[:createdDate]
    @link         = json[:link] || json[:url] || json[:original_url]
    @images       = json[:images]
  end

  def to_json
    result = {         id: @id,
                     name: @name,
                     time: @time,
                  excerpt: @excerpt,
                     tags: @tags,
             created_date: @created_date,
                     link: @link,
                   images: @images}

    BW::JSON.generate(result)
  end
end