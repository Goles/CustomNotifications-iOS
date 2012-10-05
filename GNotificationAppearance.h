//
//  GNotificationAppearance.h
//  CustomNotificationView
//
//  Created by Nicolas Goles on 9/25/12.
//  Copyright (c) 2012 Nicolas Goles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNotificationAppearance : NSObject

@property (strong) UIFont *font;
@property (strong) UIColor *textColor;
@property (strong) UIColor *backgroundColor;
@property (strong) UIColor *shadowColor;
@property (assign) CGSize shadowOffset;
@property (assign) float fontSize;
@property (assign) float cornerRadius;
@property (assign) UITextAlignment textAlignment;
@property (assign) float backgroundAlpha;
@property (assign) UIActivityIndicatorViewStyle activityIndicatorStyle;

@end
