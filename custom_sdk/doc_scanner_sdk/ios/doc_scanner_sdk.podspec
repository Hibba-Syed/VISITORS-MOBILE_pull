Pod::Spec.new do |s|
  s.name             = 'doc_scanner_sdk'
  s.version          = '1.0.0'
  s.summary          = 'Document Scanner SDK using native VisionKit'
  s.description      = <<-DESC
A Flutter plugin for document scanning using ML Kit (Android) and VisionKit (iOS).
                       DESC
  s.homepage         = 'https://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Name' => 'your@email.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform         = :ios, '13.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version    = '5.0'
end
