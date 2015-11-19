module PureLayoutMotion
end

class UIView

  LAYOUT_ATTR = {top: ALEdgeTop, bottom: ALEdgeBottom, leading: ALEdgeLeading, trailing: ALEdgeTrailing}

  def self.nw
    self.newAutoLayoutView
  end

  def pin_to_sueprview_edge(edge)
    self.autoPinEdgeToSuperviewEdge(LAYOUT_ATTR[edge])
  end

  def pin_to_superview
    self.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
  end

  def pin_to_sueprview_edge_with_offset(edge, offset)
    self.autoPinEdgeToSuperviewEdge(LAYOUT_ATTR[edge], withInset:offset)
  end

  def pin_edge_to_view_edge(my_edge, view, other_edge)
    self.autoPinEdge(LAYOUT_ATTR[my_edge], toEdge:LAYOUT_ATTR[other_edge], ofView:view)
  end

  def pin_edge_to_view_edge(my_edge, view, other_edge, inset)
    self.autoPinEdge(LAYOUT_ATTR[my_edge], toEdge:LAYOUT_ATTR[other_edge], ofView:view, withOffset:inset)
  end

  def auto_center
    self.autoCenterInSuperview
  end

  def center_h_with_view(v)
    self.autoConstrainAttribute(ALAttributeHorizontal, toAttribute:ALAttributeHorizontal, ofView:v)
  end

  def center_v_with_view(v)
    self.autoConstrainAttribute(ALAttributeVertical, toAttribute:ALAttributeVertical, ofView:v)
  end

  def pin_edge_to_view_edge_with_offset(my_edge, view, other_edge, offset)
    self.autoPinEdge(LAYOUT_ATTR[my_edge], toEdge:LAYOUT_ATTR[other_edge], ofView:view, withOffset:offset)
  end

  def pin_size(s)
    self.autoSetDimensionsToSize(s)
  end

end

