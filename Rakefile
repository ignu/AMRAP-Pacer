# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'AMRAP Pacer'
  app.codesign_certificate = 'iPhone Distribution: Leonard Smith'
  app.identifier = 'com.barrison.amrap'
  app.redgreen_style = :full
  app.interface_orientations = [:portrait]
  app.provisioning_profile = "/Users/ignu/Downloads/Amrap_Pacer_2.mobileprovision"
  app.icons = ["icon@2x.png"]
end
