Pod::Spec.new do |s|
  s.name             = 'MinterExplorer'
  s.version          = '0.1.10'
  s.summary          = 'A short description of MinterExplorer.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MinterTeam/minter-ios-explorer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sidorov.panda' => 'ody344@gmail.com' }
  s.source           = { :git => 'https://github.com/MinterTeam/minter-ios-explorer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'MinterExplorer/Classes/**/*'
  s.dependency 'MinterCore'
end
