# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'KobitoMenu'
  app.vendor_project('vendor/AXStatusItemPopup/AXStatusItemPopup', :static, :cflags => '-fobjc-arc')
  app.info_plist['LSUIElement'] = true
end
