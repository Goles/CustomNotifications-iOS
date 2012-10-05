### What is it?

![](http://i.imgur.com/ZLDAC.png)

Custom Notifications for iOS is an easy way to add Custom Notifications for your iOS Apps. I developed it for fun but has been used by some apps.

### Usage

Just add ``CustomNotificationIOS`` to your project and then import ``GCustomNotification.h``

    #import "GCustomNotification.h"

CustomNotificationIOS is distributed under the *MIT License*, check ``license.txt`` for more information. 

### GCustomNotification

Two generic methods are provided to show a notification view, one dismisses the view after a given time and the other method makes the view to _wait_ for an `NSNotification` from `NSNotificationCenter` in order to be dismissed.

```obj-c
+ (GCustomNotification *) showNotificationInView:(UIView*)view withMessage:(NSString *)message withActivityIndicator:(BOOL)hasActivityIndicator forTotalTime:(NSTimeInterval)interval;

+ (GCustomNotification *) showNotificationInView:(UIView*)view withMessage:(NSString *)message withActivityIndicator:(BOOL)hasActivityIndicator dismissOnNotification:(NSString *)notificationName;
```

### Appearance

You can configure the default appearance for all the Custom Notifications by using the `sharedAppearance` property. This is very useful if you want to display the same kind of Notification across your App.

```obj-c
// Setup Indicator Appearance
[[GCustomNotification sharedAppearance] setFont:[UIFont fontWithName:@"Courier" size:16]];
```

Currently, the supported properties for `sharedAppearance` are:
```obj-c
@property (strong) UIFont *font;
@property (strong) UIColor *textColor;
@property (strong) UIColor *backgroundColor;
@property (strong) UIColor *shadowColor;
@property (assign) UITextAlignment textAlignment;
@property (assign) UIActivityIndicatorViewStyle activityIndicatorStyle;
@property (assign) CGSize shadowOffset;
@property (assign) float fontSize;
@property (assign) float cornerRadius;
@property (assign) float backgroundAlpha;

```

### License (MIT)

Copyright (c) 2012 Nicolas Goles (http://nicolasgoles.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
