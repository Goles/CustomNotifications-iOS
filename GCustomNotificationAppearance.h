//
//  GCustomNotificationAppearance.h
//  CustomNotificationView
//
//  Created by Nicolas Goles on 9/22/12.
//  Copyright (c) 2012 Nicolas Goles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCustomNotificationAppearance : NSObject

@property (strong) UIColor *textColor;
@property (strong) UIColor *backgroundColor;
@property (strong) UIFont *font;
@property (assign) float fontSize;
@property (assign) float cornerRadius;
@property (assign) UITextAlignment textAlignment;

// Global appearance
+ (GCustomNotificationAppearance *) sharedAppearance;

// Initializers
+ (void) initDefaults:(GCustomNotificationAppearance *) appearance;

@end
