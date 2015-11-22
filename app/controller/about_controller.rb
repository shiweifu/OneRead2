class AboutController < UIViewController
  def viewDidLoad
    self.edgesForExtendedLayout = UIRectEdgeNone
    self.view.backgroundColor = "#e5e5e5".uicolor


    logo_view = UIImageView.nw
    self.view << logo_view
    logo_view.pin_size [60, 60]
    logo_view.image = 'Icon'.uiimage


    if is_iphone6?
      logo_view_top_offset = 65
      logoLabelTop = 25;
      versionLabelTop = 20;
      infoLabelBottom = 20;
    elsif is_iphone6p?
      logo_view_top_offset = 80
      logoLabelTop = 40;
      versionLabelTop = 35;
      infoLabelBottom = 35;
    else
      logo_view_top_offset = 40
      logoLabelTop = 20;
      versionLabelTop = 20;
      infoLabelBottom = 20;
    end


    logoLabel = UILabel.alloc.init
    logoLabel.font = UIFont.boldSystemFontOfSize(17)
    logoLabel.textColor = "#222222".uicolor
    logoLabel.textAlignment = NSTextAlignmentCenter
    logoLabel.text = "简洁的可定制化阅读工具"
    self.view.addSubview(logoLabel)
    
    versionLabel = UILabel.alloc.init
    versionLabel.font = UIFont.systemFontOfSize(12)
    versionLabel.textColor = "#666666".uicolor
    versionLabel.textAlignment = NSTextAlignmentCenter
    versionLabel.text = NSString.stringWithFormat(app_version)
    self.view.addSubview(versionLabel)
    
    infoLabel = UILabel.alloc.init
    infoLabel.numberOfLines = 0
    infoLabel.backgroundColor = UIColor.clearColor
    infoLabel.font = UIFont.systemFontOfSize(12)
    infoLabel.textColor = "#666666".uicolor
    infoLabel.textAlignment = NSTextAlignmentCenter
    infoLabel.text = NSString.stringWithFormat("官网：https://coding.net \nE-mail：link@coding.net \n微博：Coding \n微信：扣钉Coding")
    self.view.addSubview(infoLabel)

    logoLabel.center_v_with_view(self.view)
    logoLabel.pin_edge_to_view_edge(:top, logo_view, :bottom, logoLabelTop)

    versionLabel.center_v_with_view(self.view)
    versionLabel.pin_edge_to_view_edge(:top, logoLabel, :bottom, versionLabelTop)

    p "top_offset: #{logo_view_top_offset}"

    logo_view.center_v_with_view(self.view)
    logo_view.pin_to_sueprview_edge_with_offset(:top, logo_view_top_offset)


    webSiteLabel = UILabel.nw
    webSiteLabel.textColor = "#666666".uicolor
    webSiteLabel.font = UIFont.systemFontOfSize(12)
    webSiteLabel.text = "http://lonelygod.me/"
    self.view << webSiteLabel
    webSiteLabel.center_v_with_view(self.view)
    webSiteLabel.pin_to_sueprview_edge_with_offset(:bottom, 30)

    discoveryLabel = UILabel.nw
    discoveryLabel.textColor = "#666666".uicolor
    discoveryLabel.font = UIFont.systemFontOfSize(12)
    discoveryLabel.text = "「来自D版带着爱」"
    self.view << discoveryLabel
    discoveryLabel.center_v_with_view(self.view)
    discoveryLabel.pin_edge_to_view_edge_with_offset(:bottom, webSiteLabel, :top, -10)

    self.title = title_text
  end

  def title_text
    params['title']
    
  end
  
  
end