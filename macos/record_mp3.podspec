#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name = "record_mp3"
  s.version = "0.0.1"
  s.summary = "A new Flutter plugin."
  s.description = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage = "http://example.com"
  s.license = { :file => "../LICENSE" }
  s.author = { "Your Company" => "email@example.com" }
  s.source = { :path => "." }
  s.source_files = "Classes/**/*"
  s.public_header_files = "Classes/**/*.h"
  s.dependency "FlutterMacOS"
  s.swift_version = "5.0"
  # Flutter.framework does not contain a i386 slice.
  #s.pod_target_xcconfig = { "DEFINES_MODULE" => "YES", "EXCLUDED_ARCHS" => "i386" }

  s.osx.deployment_target = "11.0"
  s.frameworks = "AVFoundation"
  s.vendored_libraries = "Classes/Fat-Lame/lib/libmp3lame.a"
end
