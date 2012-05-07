#!/usr/bin/env ruby
require "#{ENV['TM_SUPPORT_PATH']}/lib/ui"
require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
require "#{ENV['TM_SUPPORT_PATH']}/lib/tm/detach"

conf_file = File.join(ENV['TM_BUNDLE_SUPPORT'], '/conf/remote.plist')

plist = OSX::PropertyList.load(File.read(conf_file))

output = []

TextMate.detach do
  TextMate::UI.dialog(:nib => ENV['TM_BUNDLE_SUPPORT'] + '/nibs/Remote Server Settings.nib', 
                      :parameters => plist, 
                      :center => true) do |window|
    output = window.wait_for_input
  end

  OSX::PropertyList.dump(File.open(conf_file, 'w'), output, format = :xml1)  
end