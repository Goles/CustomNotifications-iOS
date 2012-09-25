//
//  GCustomAlertView.m
//  CustomAlertView
//  Version 1.0
//
//  Copyright (c) 2012 Nicolas Goles Domic.
//

#import "GCustomNotificationView.h"
#import "GCustomNotificationAppearance.h"
#import <QuartzCore/QuartzCore.h>

enum kViewTag {
    kViewTag_Message = 99,
    kViewTag_NotificationFrame,
    kViewTag_ActivityIndicator,
    kViewTag_MessageLabel,
};


@implementation GCustomNotificationView
@synthesize appearance = _appearance;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
    }
    
    return self;
}

+ (CGRect) setupForViewFrame:(CGRect) frame andNotificationSize:(CGSize) size
{
    float panelMarginX = (frame.size.width - size.width) / 4.0f; // Calculate the x margin of the Frame
    float panelMarginY = (frame.size.height - size.height) / 4.0f; // Calculate the x margin of the Frame
    CGRect panelFrame = CGRectMake(panelMarginX, panelMarginY, size.width, size.height);  // Build a frame in the middle of the screen with proper margin    
    return panelFrame;
}

+ (GCustomNotificationView *) showNotificationInView:(UIView*) view
                                              ofSize:(CGSize) size
                                         withMessage:(NSString *) message
                               withActivityIndicator:(BOOL) hasActivityIndicator
                                        forTotalTime:(NSTimeInterval) interval
{
    CGRect customFrame = [self setupForViewFrame:view.frame andNotificationSize:size];
    GCustomNotificationView *customView = [[GCustomNotificationView alloc] initWithFrame:customFrame message:message dismissAfterTime:interval];
    UIActivityIndicatorView *indicatorView = [GCustomNotificationView activityIndicator];
    
    if (hasActivityIndicator) {
        size.width += indicatorView.frame.size.width + indicatorView.frame.size.width / 2.0f;
    }

    // Add Activity Indicator if user wants to.
    if (hasActivityIndicator) {
        UILabel *messageView = (UILabel *)[customView viewWithTag:kViewTag_MessageLabel];
        CGSize sz = [messageView.text sizeWithFont:messageView.font];
        messageView.textAlignment = UITextAlignmentRight;
        float widthWithIndicator = sz.width + indicatorView.frame.size.width * 1.2f;
        float centeredX = (customView.frame.size.width - widthWithIndicator) / 2.0f;

        messageView.frame = CGRectMake(centeredX,
                                       messageView.frame.origin.y,
                                       widthWithIndicator,
                                       sz.height);

        customView.activityIndicator = indicatorView;
        [messageView addSubview:indicatorView];
    }

    [view addSubview:customView];
    return customView;
}

+ (GCustomNotificationView *) showNotificationInView:(UIView*)view
                                              ofSize:(CGSize) size
                                         withMessage:(NSString *)message
                               withActivityIndicator:(BOOL) hasActivityIndicator
                               dismissOnNotification:(NSString *) notificationName
{
    CGRect customFrame = [self setupForViewFrame:view.frame andNotificationSize:size];
    GCustomNotificationView *customView = [[GCustomNotificationView alloc] initWithFrame:customFrame message:message dismissAfterTime:kNoDismissInterval];
    UIActivityIndicatorView *indicator = [GCustomNotificationView activityIndicator];
    
    // Add Activity Indicator if user wants to.
    if (hasActivityIndicator) {
        
        indicator.frame = customView.frame;
        customView.activityIndicator = indicator;
        [customView addSubview:customView.activityIndicator];
    }

    // Listen in notification Center
    if (notificationName) {
       [[NSNotificationCenter defaultCenter] addObserver:customView
                                                 selector:@selector(dismissOnNotification:)
                                                     name:notificationName
                                                  object:nil];
    }
    
    [view addSubview:customView];
    return customView;
}

+ (GCustomNotificationView *) notificationWithFrame:(CGRect) frame
                                        withMessage:(NSString *) message
                                       forTotalTime: (NSTimeInterval) interval
{
    GCustomNotificationView *customView = [[GCustomNotificationView alloc] initWithFrame:frame message:message dismissAfterTime:interval];
    return customView;
}

- (id) initWithFrame:(CGRect) frame message:(NSString *) message dismissAfterTime:(NSTimeInterval) interval
{
    if (!self.appearance) {
        self.appearance = [GCustomNotificationAppearance sharedAppearance];
    }
    
    if (self = [super initWithFrame:frame]) {
        _notificationView = [[UIView alloc] initWithFrame:frame];
        _notificationView.tag = kViewTag_NotificationFrame;
        UILabel *label = [[UILabel alloc] init];

        // Perform View Customization
        _notificationView.backgroundColor = _appearance.backgroundColor;
        _notificationView.alpha = 0.0;
        _notificationView.layer.cornerRadius = _appearance.cornerRadius;
        _notificationView.layer.masksToBounds = YES;

        // Perform Label customization
        label.text = message;
        label.font = _appearance.font;
        label.textColor = _appearance.textColor;
        label.textAlignment = _appearance.textAlignment;
        label.backgroundColor = [UIColor clearColor];
        CGSize sz = [label.text sizeWithFont:label.font];
        label.frame = CGRectMake(0,
                                 (_notificationView.frame.size.height / 2.0f - sz.height / 2.0),
                                 _notificationView.frame.size.width,
                                 sz.height);
        label.tag = kViewTag_MessageLabel;
        
        [self addSubview:_notificationView];
        [_notificationView addSubview:label];

        [UIView animateWithDuration:0.4
                         animations:^ {_notificationView.alpha = 0.6;}
                         completion:nil];

        if (interval > 0) {
            [self performSelector:@selector(dismiss:) withObject:_notificationView afterDelay:interval];
        }
    }

    return self;
}

+ (UIActivityIndicatorView *) activityIndicator
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.tag = kViewTag_ActivityIndicator;
    activityIndicator.hidesWhenStopped = YES;
    [activityIndicator startAnimating];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    return activityIndicator;
}

- (void) dismissOnNotification:(NSNotification *) notification
{
    [self removeFromSuperview];
}

- (void) dismiss:(UIView *) view
{
    [UIView animateWithDuration:0.4
                     animations:^ {
                         view.alpha = 0.0;
                     }
                     completion:^(BOOL didFinish) {
                         [self removeFromSuperview];
                     }];
}

- (GCustomNotificationAppearance *) appearance
{
    if (!_appearance) {
        _appearance = [GCustomNotificationAppearance sharedAppearance];
    }
    return _appearance;
}

- (void) setAppearance:(GCustomNotificationAppearance *)appearance
{
    _appearance = appearance;
}


@end
