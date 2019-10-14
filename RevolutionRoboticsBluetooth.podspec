#
# Be sure to run `pod lib lint RevolutionRoboticsBluetooth.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RevolutionRoboticsBluetooth'
  s.version          = '0.1.0'
  s.summary          = 'A Bluetooth SDK for Revolution Robotics Robot Controller'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A Bluetooth SDK for Revolution Robotics Robot Controller.'

  s.homepage         = 'https://github.com/RevolutionRobotics/RevolutionRoboticsBluetoothIOS.git'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'GPLv3', :file => 'LICENSE' }
  s.author           = { 'Gabor Nagy Farkas' => 'gabor.nagy.farkas@supercharge.io' }
  s.source           = { :git => 'https://github.com/RevolutionRobotics/RevolutionRoboticsBluetoothIOS.git', :tag => s.version }
  s.swift_version = "5.0"
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'RevolutionRoboticsBluetooth/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RevolutionRoboticsBluetooth' => ['RevolutionRoboticsBluetooth/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'CoreBluetooth'
  s.dependency 'CryptoSwift', '~> 1.0'
end
