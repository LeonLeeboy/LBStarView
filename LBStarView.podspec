

Pod::Spec.new do |s|
  s.name             = 'LBStarView'
  s.version          = '1.1.0'
  s.summary          = '评分轮子'


  s.description      = <<-DESC
                    TODO: 商品的评价分数轮子
                       DESC

  s.homepage         = 'https://github.com/LeonLeeboy'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'j1103765636@iCloud.com' => '1103765636@qq.com' }
  s.source           = { :git => 'https://github.com/LeonLeeboy/LBStarView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'LBStarView/Classes/**/*'
  s.frameworks = 'UIKit', 'MapKit'
   s.resource = 'LBStarView/Assets/*'


end
