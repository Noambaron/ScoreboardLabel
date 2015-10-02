
Pod::Spec.new do |s|

s.name     	= "ScoreboardLabel"
s.version      = "0.1"
s.summary      = "A label that switches texts by animating a flip of each letter - Written in Swift, using POP"

s.description  = <<-DESC
A label that switches texts by animating a flip of each letter - Written in Swift, using POP.
DESC

s.homepage 	= "https://github.com/Noambaron/ScoreboardLabel"
s.screenshots  = "https://github.com/Noambaron/ScoreboardLabel/blob/master/ScoreboardLabel.gif"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author         	= { "Noam bar-on" => "https://www.linkedin.com/in/noambaron" }
s.social_media_url   = ""
s.platform 	= :ios, "8.0"
s.source   	= { :git => "https://github.com/Noambaron/ScoreboardLabel.git", :tag => s.version }
s.source_files  = "ScoreboardLabel/**/*.swift"

s.requires_arc = true

# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
s.dependency "pop", "~> 1.0"

end



