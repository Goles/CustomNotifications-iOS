//
//  GCustomNotificationAppearance.m
//  CustomNotificationView
//
//  Created by Nicolas Goles on 9/22/12.
//  Copyright (c) 2012 Nicolas Goles. All rights reserved.
//

#import "GCustomNotificationAppearance.h"

@implementation GCustomNotificationAppearance

+ (GCustomNotificationAppearance *) sharedAppearance
{
    static dispatch_once_t once;
    static GCustomNotificationAppearance *sharedInstance = nil;

    dispatch_once(&once, ^{
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
            [GCustomNotificationAppearance initDefaults:sharedInstance];
        }
    });

    return sharedInstance;
}

+ (void) initDefaults:(GCustomNotificationAppearance *) appearance
{
    appearance.fontSize = 18.0f;
    appearance.font = [UIFont fontWithName:@"Helvetica Neue" size:appearance.fontSize];
    appearance.textColor = [UIColor whiteColor];
    appearance.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9];
    appearance.cornerRadius = 5.0f;
    appearance.textAlignment = UITextAlignmentCenter;
}

@end
