# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'motion-cocoapods'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  app.name = '一读'

  app.version                = '1.0.201508240853'
  app.short_version          = '1.0'

  app.identifier           = 'us.dollop.oneread'
  app.deployment_target    = '8.4'
  app.sdk_version          = '9.1'

  app.frameworks          += %w(UIKit)
  app.icons                = ['Icon@3x.png', 'Icon-60@2x.png', 'Icon-60.png']


  app.archs['iPhoneOS']        << 'arm64'
  app.archs['iPhoneSimulator'] << 'x86_64'

  app.info_plist['CFBundleDevelopmentRegion'] = 'zh_CN'
  app.info_plist['CFBundleIdentifierKey'] = 'us.dollop.oneread'
  app.info_plist['NSAppTransportSecurity'] = {'NSAllowsArbitraryLoads' => true}
  app.info_plist['CFBundleURLTypes']          = [
      {
          'CFBundleURLName'    => 'pocket',
          'CFBundleURLSchemes' => ['pocketapp5678', 'wxbfffd0ddce3278c7']
      },
      {
          'CFBundleURLName'    => 'weixin',
          'CFBundleURLSchemes' => ['wxb89d2a6ca7643c4f']
      }
  ]

  app.pods do
    pod 'PureLayout'
    pod 'SDWebImage'
    pod 'SSDataSources'
    pod 'SWRevealViewController'
    pod 'HHRouter'
    pod 'SVProgressHUD'
    pod 'OpenShare'
    pod 'SVWebViewController'
    pod 'EGOCache'
    pod 'MWFeedParser'
    pod 'NSHash', '~> 1.0.1'
    pod 'MCSwipeTableViewCell'
    pod 'AVOSCloud'
  end

  app.release do
    app.codesign_certificate = 'iPhone Distribution: shi weifu (9KL9R4225X)'
    app.provisioning_profile = '/Users/shiweifu/Downloads/oneread_appstore_dist.mobileprovision'
  end

  app.development do
    app.provisioning_profile = './development.mobileprovision'
  end

end
