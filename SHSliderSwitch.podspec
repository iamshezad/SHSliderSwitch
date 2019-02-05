Pod::Spec.new do |s|
s.name         = "SHSliderSwitch"
s.version      = "1.0"
s.summary      = "A framework that implements a slider switch."
s.description  = "SHSliderSwitch is a simple lightweight library to implement an animated slider switch."

s.homepage     = "https://github.com/iamshezad/SHSliderSwitch"

s.license      = { :type => 'MIT', :file => 'LICENSE' }

s.author       = { "iamShezad" => "shezadahamed95@gmail.com" }

s.source       = { :git => "https://github.com/iamshezad/SHSliderSwitch.git", :tag => "1.0" }

s.source_files  = "SHSliderSwitch/*.{swift,h,m}"

s.ios.deployment_target = "11.0"

end
