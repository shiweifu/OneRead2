
# 只显示title的cell
class BasicCell < SSBaseTableCell

  def self.cellStyle
    UITableViewCellStyleDefault
  end

  def model=(m)
    self.textLabel.text = m.name
  end

  def self.height_for_model(m)
    44
  end

end
