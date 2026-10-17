#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_ringtone_player_advanced'
  s.version          = '5.0.1'
  s.summary          = 'Simple ringtone player plugin.'
  s.description      = <<-DESC
A simple ringtone player plugin.
                       DESC
  s.homepage         = 'https://github.com/nafiskabbo/flutter_ringtone_player_advanced'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Nafis Kabbo' => 'nafiskabbo30@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'flutter_ringtone_player_advanced/Sources/flutter_ringtone_player_advanced/**/*'
  s.public_header_files = 'flutter_ringtone_player_advanced/Sources/flutter_ringtone_player_advanced/include/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
end
