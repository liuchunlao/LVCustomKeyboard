Pod::Spec.new do |s|
 s.name         = "LVKeyboard"
 s.version      = "1.0"
 s.summary      = "The easiest way to use custom keyboard"
 s.homepage     = "https://github.com/liuchunlao/LVCustomKeyboard"
 s.license      = "MIT"
 s.authors      = { 'liuchunlao' => 'liuchunlao@qq.com'}
 s.platform     = :ios, "7.0"
 s.source       = { :git => "https://github.com/liuchunlao/LVCustomKeyboard.git", :tag => "1.0" }
 s.source_files = "LVCustomKeyboard/LVKeyboard/*.{h,m}"
 s.requires_arc = true
end