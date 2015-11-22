module Common

  def feedback_info
    app_version    = s = NSBundle.mainBundle.infoDictionary.objectForKey("CFBundleVersion")
    device_model   = UIDevice.currentDevice.model
    system_version = UIDevice.currentDevice.systemVersion
    return NSString.stringWithFormat("\n\n\n设备: %@ \niOS版本: %@ \n客户端版本: v%@", device_model, system_version, app_version)

  end

  def class_from_string(s)
    Module.const_get(s)
  end

  def msg(text, type=:normal)
    case type
      when :success
        SVProgressHUD.showSuccessWithStatus(text)
      when :failure
        SVProgressHUD.showErrorWithStatus(text)
      else
        SVProgressHUD.showWithStatus(text)
    end
  end

  def hide_msg
    SVProgressHUD.dismiss
  end

  def read_file(filename)
    name, ext =  filename.split(".")

    path = NSBundle.mainBundle.pathForResource(name, ofType: ext)

    puts("path:", path)


    string = NSString.stringWithContentsOfFile(path,
                                               encoding: NSUTF8StringEncoding,
                                               error: nil)
  end

  def date_to_str(d, f='yyyyMMdd')
    d.string_with_format(f, options={:unicode => true})
  end

  def cache_object(obj, k)
    NSUserDefaults[k] = obj
  end

  def remove_key(k)
    NSUserDefaults[k] = nil
  end

  def object_from_cache(k)
    NSUserDefaults[k]
  end

  def is_iphone6?
    [Device.screen.width, Device.screen.height] == [750/2, 1334/2]
  end

  def is_iphone6p?
    [Device.screen.width, Device.screen.height] == [1242/2, 2208/2]
  end

  def is_iphone5?
    [Device.screen.width, Device.screen.height] == [640/2, 1136/2]
  end

  def app_version
    NSBundle.mainBundle.objectForInfoDictionaryKey("CFBundleVersion")
  end

  def present_controller(c)
    sd = App.shared.delegate
    nav = UINavigationController.alloc.initWithRootViewController(c)
    self.presentViewController(nav,  animated:true, completion:nil)
  end

  def open_controller(c)
    sd = App.shared.delegate
    nav = UINavigationController.alloc.initWithRootViewController(c)
    sd.revealController.frontViewController = nav
    self.revealViewController.revealToggle(nil)
  end

  def register_router(r, &callback)
    HHRouter.shared.map(r, toBlock:callback)
  end

  def find_router(r, dic={})
    b = HHRouter.shared.matchBlock(r)
    c = b.call(dic)
    c
  end


end

class UIImageView

  def set_image_url(url, placeholder_image=nil)
    placeholder_image = 'placeholder'.uiimage unless placeholder_image.is_a? UIImage
    self.sd_setImageWithURL(url.nsurl, placeholderImage: placeholder_image)
  end

end

