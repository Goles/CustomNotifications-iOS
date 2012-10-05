//
//  GCustomNotificationAppearance.h
//  CustomNotificationView
//
//  Created by Nicolas Goles on 9/22/12.
//  Copyright (c) 2012 Nicolas Goles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GNotificationAppearance;

@interface GAppearanceFactory : NSObject


// Initializers
+ (GNotificationAppearance *) defaultAppearance;
@end
