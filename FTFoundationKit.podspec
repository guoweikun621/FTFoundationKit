#
#  Be sure to run `pod spec lint FTFoundationKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "FTFoundationKit"
  s.version      = "1.0.0"
  s.summary      = "FTFoundationKit 是iOS基础服务工程"

  s.description  = <<-DESC
                    此工程为Fosun - iOS基础服务工程，专门为互联网项目准备。不作其它用处。
                   DESC

  s.homepage     = "https://github.com/guoweikun621/FTFoundationKit"

  s.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "郭伟坤" => "guoweikun621@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/guoweikun621/FTFoundationKit.git", :tag => "#{s.version}" }


  s.source_files  = "Sources/NetworkServer/*.{swift}","Sources/Common/*.{swift}"
  s.frameworks = "UIKit", "Foundation"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "Alamofire", "~> 4.4.0"
  s.dependency 'SwiftyJSON', '~> 3.1.4'
  s.dependency 'WKBaseServicesSwift', '~>3.0.3'
end
