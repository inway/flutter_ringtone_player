#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_ringtone_player'
  s.version          = '0.0.1'
  s.summary          = 'Simple ringtone player plugin.'
  s.description      = <<-DESC
A simple ringtone player plugin.
                       DESC
  s.homepage         = 'http://github.com/inway/flutter_ringtone_player'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'InWay.pro' => 'info@inway.pro' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

