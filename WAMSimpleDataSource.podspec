Pod::Spec.new do |s|
  s.name         = "WAMSimpleDataSource"
  s.version      = "0.1.1"
  s.summary      = "An easier way to create readable static table view data source"
  s.homepage     = "https://github.com/WAMaker/WAMSimpleDataSource"
  s.author       = { "WAMaker" => "https://github.com/WAMaker" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.source       = { :git => "https://github.com/WAMaker/WAMSimpleDataSource.git", :tag => s.version.to_s }

  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source_files = "WAMSimpleDataSource/*.{h,m}"
end
