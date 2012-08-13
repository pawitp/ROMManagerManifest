require 'rubygems'
require 'json'

if ARGV[0] == nil then
  puts "ruby checkdeviceversion.rb <device> <version>"
  exit 1
end
key = ARGV[0]

if ARGV[1] == nil then
  puts "ruby checkdeviceversion.rb <device> <version>"
  exit 1
end

devices = JSON.parse(File.open(File.dirname(__FILE__) + "/devices.js").read)
found_device = nil
devices["devices"].each do |device|
  if device["key"] == key then
    found_device = device
  end
end


if found_device == nil then
  puts "device not found"
  exit 1
end

touch_recovery = ENV['BOARD_TOUCH_RECOVERY'] != nil
if touch_recovery
  puts "touch version: "
  if found_device['touch_version'] == nil
    exit 1
  end
  version = found_device['touch_version']
else
  puts "version:"
  version = found_device['version']
end

puts version

if ARGV[1] <= version
  puts "version #{ARGV[1]} is outdated, not updating"
  exit 1
end

puts "Updating ROMManagerManifest to #{ARGV[1]}."