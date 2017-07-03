# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
inhibit_all_warnings!
target 'CinemaHub' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CinemaHub
  pod 'ChameleonFramework'
  pod 'BonMot'
  pod 'Hero' , :git => 'https://github.com/lkzhao/Hero'
  pod 'SwiftIcons', :git => 'https://github.com/ranesr/SwiftIcons'
  pod 'HCSStarRatingView', '~> 1.5'
  pod 'XLPagerTabStrip', '~> 7.0'
  pod 'BMPlayer'
  pod 'Moya'
  pod 'SnapKit', '~> 3.2.0'
  pod 'YoutubeSourceParserKit' , :git => 'https://github.com/lennet/YoutubeSourceParserKit', :branch => 'master'
  pod 'Kingfisher', '~> 3.0'
  target 'CinemaHubTests' do
      inherit! :search_paths
      pod 'Quick'
      pod 'Nimble'
      pod 'Mockingjay'
  end
  
  # Disable Code Coverage for Pods projects
  post_install do |installer_representation|
      installer_representation.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
              config.build_settings['SWIFT_VERSION'] = '3.0'
              config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
          end
      end
  end
end
