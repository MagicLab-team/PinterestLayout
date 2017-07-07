Pod::Spec.new do |s|
    s.name         = "PinterestLayout"
    s.version      = "1.0.1"
    s.summary      = "Pinterest like layout."
    s.homepage     = "https://github.com/romansorochak"
    s.license      = "MIT"
    s.author             = { "Roman Sorochak" => "roman.sorochak@gmail.com" }
    s.platform     = :ios, "8.0"
    s.ios.deployment_target = "8.0"
    s.source       = { :git => "https://github.com/MagicLab-team/PinterestLayout.git", :tag => s.version }
    s.source_files  = "PinterestLayout/*.swift"
end
