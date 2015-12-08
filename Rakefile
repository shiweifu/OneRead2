# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'motion-cocoapods'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  app.name = '一读'

  app.version              = '1.1.201512081724'
  app.short_version        = '1.1'

  app.identifier           = 'us.dollop.oneread'
  app.deployment_target    = '7.0'
  app.sdk_version          = '9.1'

  app.frameworks          += %w(UIKit)
  app.icons                = ['Icon@3x.png', 'Icon-60@2x.png', 'Icon-60.png']


  app.archs['iPhoneOS']        << 'arm64'
  app.archs['iPhoneSimulator'] << 'x86_64'

  app.info_plist['CFBundleDevelopmentRegion'] = 'zh_CN'
  app.info_plist['CFBundleIdentifierKey'] = 'us.dollop.oneread'
  app.info_plist['NSAppTransportSecurity'] = {'NSAllowsArbitraryLoads' => true}
  app.info_plist['LSApplicationQueriesSchemes'] = ['wechat', 'weixin']
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
    pod 'HTMLReader'
    pod 'AVOSCloud'
    pod 'LeanCloudFeedback'
  end

  app.release do
    app.codesign_certificate = 'iPhone Distribution: shi weifu (9KL9R4225X)'
    app.provisioning_profile = '/Users/shiweifu/Downloads/oneread_appstore_dist.mobileprovision'
    # app.provisioning_profile = '/Users/shiweifu/Downloads/oneread_adhoc_dist.mobileprovision'
    # app.entitlements['beta-reports-active'] = true
  end


  app.development do
    app.codesign_certificate = 'iPhone Developer: shi weifu (W2W2V39367)'
    app.provisioning_profile = '/Users/shiweifu/Downloads/oneread_development.mobileprovision'
  end

end
