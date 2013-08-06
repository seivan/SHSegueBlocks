Pod::Spec.new do |s|
  name           = "SHFastEnumerationBlocks"
  url            = "https://github.com/seivan/#{name}"
  git_url        = "#{url}.git"
  s.name         = name
  version        = "1.0.0"
  source_files   = "#{name}/**/*.{h,m}"

  s.version      = version
  s.summary      = "Blocks for NSFastEnumeration"
  s.description  = <<-DESC
  --------------------------------
                    DESC

  s.homepage     = url
  s.license      = 'MIT'
  s.author       = { "Seivan Heidari" => "seivan.heidari@icloud.com" }
  
  s.source       = { :git => git_url, :tag => version}
  
  
  #s.platform  = :ios, "6.0"
  s.ios.deployment_target = "6.0"
  s.osx.deployment_target = "10.8"

  s.source_files = source_files
  s.requires_arc = true


end
