/***************************************************************************

 GCustomNotificationView.h
 CustomNotificationView
 Version 1.0

 Copyright (c) 2012 Nicolas Goles Domic.

 Permission is hereby granted, free of charge, to any person obtaining a
 copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:

 The above copyright notice and this permission notice shall be included
 in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 ***************************************************************************/

#import <UIKit/UIKit.h>

@class GCustomNotificationAppearance;
@interface GCustomNotificationView : UIView

#define kNoDismissInterval -1.0

@property (strong) UIView *notificationView;
@property (strong) UIActivityIndicatorView *activityIndicator;
@property (strong) GCustomNotificationAppearance *appearance;

// Each of showNotificationInView: method creates a notification inside a given view.
+ (GCustomNotificationView *) showNotificationInView:(UIView*)view
                                              ofSize:(CGSize) size
                                         withMessage:(NSString *)message
                               withActivityIndicator:(BOOL) hasActivityIndicator
                               dismissOnNotification:(NSString *) notificationName;

+ (GCustomNotificationView *) showNotificationInView:(UIView*)view
                                              ofSize:(CGSize) size
                                         withMessage:(NSString *)message
                               withActivityIndicator:(BOOL) hasActivityIndicator
                                        forTotalTime:(NSTimeInterval) interval;

// Usually you use this method directly only if you want to customize your CustomNotificationView beyond the defaults.
+ (GCustomNotificationView *) notificationWithFrame:(CGRect) frame
                                        withMessage:(NSString *) message
                                       forTotalTime:(NSTimeInterval) interval;
@end