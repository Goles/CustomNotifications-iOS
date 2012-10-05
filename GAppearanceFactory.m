//
//  GCustomNotificationAppearance.m
//  CustomNotificationView
//
//  Created by Nicolas Goles on 9/22/12.
//  Copyright (c) 2012 Nicolas Goles. All rights reserved.
//

#import "GAppearanceFactory.h"
#import "GNotificationAppearance.h"

static GNotificationAppearance *_defaultAppearance = nil;

@implementation GAppearanceFactory

// Default values
+ (GNotificationAppearance *) defaultAppearance
{
    if (!_defaultAppearance) {
        _defaultAppearance = [[GNotificationAppearance alloc] init];
    }
    _defaultAppearance.fontSize = 18.0f;
    _defaultAppearance.font = [UIFont fontWithName:@"Helvetica Neue" size:_defaultAppearance.fontSize];
    _defaultAppearance.textColor = [UIColor whiteColor];
    _defaultAppearance.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    _defaultAppearance.backgroundAlpha = 1.0f;
    _defaultAppearance.shadowColor = [UIColor blackColor];
    _defaultAppearance.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _defaultAppearance.cornerRadius = 5.0f;
    _defaultAppearance.textAlignment = UITextAlignmentCenter;
    _defaultAppearance.activityIndicatorStyle = UIActivityIndicatorViewStyleWhite;
    return _defaultAppearance;
}

@end
