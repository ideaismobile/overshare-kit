Pod::Spec.new do |s|
  s.name         = "OvershareKit"
  s.version      = "1.0.4"
  s.summary      = "A soup-to-nuts sharing library for iOS."
  s.homepage     = "https://github.com/overshare/overshare-kit"
  s.license      = { :type => 'MIT', :file => 'LICENSE'  }
  s.author       = { "Jared Sinclair" => "desk@jaredsinclair.com", "Justin Williams" => "justin@carpeaqua.com" }
  s.source       = { :git => "https://github.com/overshare/overshare-kit.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.frameworks   = 'UIKit'
  
  s.compiler_flags = "-fmodules"
  
  s.ios.deployment_target = '7.0'
  
  s.source_files = ['Overshare Kit/*.{h,m}']

#  s.resource_bundles = {
#        'OSKLocalizations' => 'Overshare Kit/Localizations/*' ,
#        'OvershareKit' => ['Overshare Kit/Images/*', 'Overshare Kit/*.xib']
#  }
  s.resources    = ['Overshare Kit/Images/*', 'Overshare Kit/*.xib', 'Overshare Kit/OSKLocalizations.bundle']

  s.dependency 'Facebook-iOS-SDK'
end
