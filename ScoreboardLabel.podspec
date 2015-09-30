
Pod::Spec.new do |s|

s.name     	= "ScoreboardLabel"
s.version      = "0.1"
s.summary      = "A label that switches texts by animating a flip of each letter - Swift"

s.description  = <<-DESC
A label that switches texts by animating a flip of each letter - Swift.
DESC

s.homepage 	= "https://github.com/Noambaron/ScoreboardLabel"
# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author         	= { "Noam bar-on" => "bar.on.noam1.com" }
s.social_media_url   = ""
s.platform 	= :ios, "8.0"
s.source   	= { :git => "https://github.com/Noambaron/ScoreboardLabel.git", :tag => s.version }
s.source_files  = "ScoreboardLabel/**/*.swift"

s.requires_arc = true

# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
s.dependency "pop", "~> 1.0"

end



