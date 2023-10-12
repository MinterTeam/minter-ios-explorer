Pod::Spec.new do |s|
  s.name             = 'MinterExplorer'
  s.version          = '1.2.4'
  s.summary          = 'A short description of MinterExplorer.'
  s.description      = <<-DESC
Minter Explorer SDK
                       DESC

  s.homepage         = 'https://github.com/MinterTeam/minter-ios-explorer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sidorov.panda' => 'ody344@gmail.com' }
  s.source           = { :git => 'https://github.com/MinterTeam/minter-ios-explorer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://medium.com/@MinterTeam'
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.source_files = 'MinterExplorer/Classes/**/*'
  s.dependency 'MinterCore'
end
