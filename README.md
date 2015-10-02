# ScoreboardLabel
A label that switches texts by animating a flip of each letter - Written in Swift, using POP

[![Version](https://img.shields.io/cocoapods/v/ScoreboardLabel.svg?style=flat)](http://cocoapods.org/pods/ScoreboardLabel)
[![License](https://img.shields.io/cocoapods/l/ScoreboardLabel.svg?style=flat)](http://cocoapods.org/pods/ScoreboardLabel)
[![Platform](https://img.shields.io/cocoapods/p/ScoreboardLabel.svg?style=flat)](http://cocoapods.org/pods/ScoreboardLabel)

![Animation](ScoreboardLabel.gif)

## What ScoreboardLabel Does

* iOS 8.0+
* xCode 6+
* Lets you save optional meta data alongside each image
* Leaves all network activity to you
* Lets you add your functionality in key points through the process 
* Uses an asynchronous and serial approach processing each image request

## How ScoreboardLabel works

ScoreboardLabel is composed of three main objects. the cache manager, the image request object, and the image file (Realm) object. The image file is the Realm scheme to be saved. The image request object is an abstract vehicle used to process each image operation (save/ retrieve/ delete) and the cache manager is the coordinator and API.


## Example App 

To run the example project, clone the repo, and run `pod install` from the Example directory first.
You will also need to insert a FlickerAPIFey in the predefined macro on FlickrAPIKey.h
A free FlickrAPIKey is available [here](http://www.flickr.com/services/api/misc.api_keys.html)

## Installation

ScoreboardLabel is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```objective-c
pod "ScoreboardLabel"
```

## Get Started


```objective-c
let font = aFont //any font, any size
let image = anImage //the letter backgroud image
let color = aUIColor

label = ScoreboardLabel(backgroundImage: image! ,text: "TEXT-FROM", flipToText: "TEXT-TO", font:font, textColor:color)

label.interval = Double(0.4) //each letter flip time

label.completionHandler = { (finished:Bool) in
if finished == true {
//label as finished animating
}
}

label.center = view.center

view.addSubview(label)

```

## Start Animating

```objective-c
label.flip(true) //true = flip back and forth between texts. false = flip once from text to text and thats it
```

## Stop Animating

```objective-c
label.stopFlipping() //Will stop animating after finishing current flip
```


## Providing Source Images to ScoreboardLabel

Normally there is no need to manually save images, as any image downloaded through the cache manager will be automatically saved. But if you need to manually insert an image you can do the following:
```objective-c
-(void) saveImage:(UIImage *)image andMetaData:(NSDictionary *)metaData {

[[ScoreboardLabel sharedManager] saveImage:image metaData:metaData withCompletion:^(BOOL success, UIImage *savedImage, NSDictionary *savedMetaData, NSError * error) {

if (success) {
//image was saved successfully 

}else {
//image was not save. handle error gracefully
}
}];
}
```


Provide an image to save, (and you can also pass a metaData NSDictionary that will be saved with the image and returned on completion). Cache manager will do the following:

1. Call the abstract method [willSaveImageWithRequest...] on your subclassed ImageRequest. That gives you a chance to upload the image to server or process it anyway you like. Note that you must return a unique file_id in the completion block. 

2. When receiving the file_id the cache manager will insert the image to the realm persistent cache and the memory cache, and will call its completion block once done.

##Retrieving Images From ScoreboardLabel

The cache manager never returns a UIImage directly. The requested image is included in the completion block. The return value will indicate whether or not the image already exists in the image cache. This is an asynchronous method but if the requested image already exists in the cache, the completion block will be called immediately:

```objective-c
-(void) getImageWithSize:(CGSize)size  fileId:(long)file_id metaData:metaData {

BOOL imageExists = [[ScoreboardLabel sharedManager] getImageWithSize:size fileId:file_id metaData:metaData withCompletion:^(UIImage *image, long file_id) {

if (image) {

[self.someImageView setImage:image];
}
}];

if (imageExists == NO) {

[self.someImageView setImage:somePlaceHolderImage;
}
}
```
Provide a size, and a file id (and you can also pass metaData object that will be returned on completion) and the cache manager will do the following:

1. Look for the image in memory cache and return it through the completion block immediately if found. Return YES as the method return value

2. If not in memory it will look for the image in realm dataase and return it through the completion block immediately if found. Return YES as the method return value

3. If not on either the method will return NO immediately and also call asynchronously your subclass of NBImageRequest [request isAskingForImageWithFileId...]. When that returns, perhaps some time later, the completion block will be called with the image.

## Check if an Image is Available in ScoreboardLabel

ScoreboardLabel will check in memory cache and also persistent cache and will return a boolean indicating whether image is available. This does not run any network activity. only checks inside cache

```objective-c
BOOL imageExists = [[ScoreboardLabel sharedManager] hasImageForFileId:file_id size:size];
```

## Removing Images From ScoreboardLabel

To remove an image from the cache provide a file_id and size (in order to uniquely identify the image file, and check for the completion block for success:

```objective-c
-(void) removeImageWithSize:(CGSize)size  fileId:(long)file_id {

[[ScoreboardLabel sharedManager] removeImageWithSize:size fileId:file_id withCompletion:^(BOOL success
, long file_id) {

if (success) {

//image was deleted successfully;
}
}];
}
```

## Clearing memory cache

If needed, mainly when receiving a memory warning, its recommended to clear the memory cache. Note that this will only free the images from memory and they will all persist and be available on the (high performance) realm database, so performance should not be reduced.

```objective-c
[[ScoreboardLabel sharedManager] freeMemoryCache];
```

## Collaboration
Feel free to collaborate with ideas, issues and/or pull requests.


## Author

Noam Bar-on, bar.on.noam1@gmail.com

## License

The MIT License (MIT)

Copyright (c) 2015 Noam Bar-on.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

<!--=======-->
<!--A label that switches texts by animating a flip of each letter - Written in Swift, using POP-->
