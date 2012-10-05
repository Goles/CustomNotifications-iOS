//
//  GCustomAlertView.m
//  CustomAlertView
//  Version 1.0
//
//  Copyright (c) 2012 Nicolas Goles Domic.
//

#import "GCustomNotification.h"
#import <QuartzCore/QuartzCore.h>
#import "GAppearanceFactory.h"
#import "GNotificationAppearance.h"

enum kViewTag {
    kViewTag_Message = 99,
    kViewTag_NotificationFrame,
    kViewTag_ActivityIndicator,
    kViewTag_MessageLabel,
};

static GNotificationAppearance *_sharedAppearance = nil;

@implementation GCustomNotification

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
    }
    
    return self;
}

#pragma mark -
#pragma mark Static Methods

+ (void) positionUIView:(UIView *)viewA inView:(UIView *)viewB
{
    float centeredX = (viewB.frame.size.width - viewA.frame.size.width) / 2.0;
    float centeredY = (viewB.frame.size.height - viewA.frame.size.height) / 2.0;
    viewA.frame = CGRectMake(centeredX, centeredY, viewA.frame.size.width, viewA.frame.size.height);
}

+ (GCustomNotification *) notificationViewWithMessage:(NSString *) message
                                        activityIndicator:(BOOL) hasActivityIndicator
                                         totalDismissTime:(NSTimeInterval) interval
{
    GCustomNotification *customNotificationView = [[GCustomNotification alloc] initWithMessage:message andDismissAfterTime:interval];

    if (hasActivityIndicator) {
        [GCustomNotification pushActivityIndicatorInCustomView:customNotificationView];
    }

    return customNotificationView;
}

+ (GCustomNotification *) showNotificationInView:(UIView*) view
                                         withMessage:(NSString *) message
                               withActivityIndicator:(BOOL) hasActivityIndicator
                                        forTotalTime:(NSTimeInterval) interval
{
    GCustomNotification *customView = [GCustomNotification notificationViewWithMessage:message
                                                                             activityIndicator:hasActivityIndicator
                                                                              totalDismissTime:interval];
    [self positionUIView:customView inView:view];
    [view addSubview:customView];
    return customView;
}

+ (GCustomNotification *) showNotificationInView:(UIView*) view
                                         withMessage:(NSString *) message
                               withActivityIndicator:(BOOL) hasActivityIndicator
                               dismissOnNotification:(NSString *) notificationName
{

    GCustomNotification *customView = [GCustomNotification notificationViewWithMessage:message
                                                                             activityIndicator:hasActivityIndicator
                                                                              totalDismissTime:kNoDismissInterval];
    // Listen in notification Center
    if (notificationName) {
       [[NSNotificationCenter defaultCenter] addObserver:customView
                                                 selector:@selector(dismissOnNotification:)
                                                     name:notificationName
                                                  object:nil];
    }

    [self positionUIView:customView inView:view];
    [view addSubview:customView];
    return customView;
}

+ (void) pushActivityIndicatorInCustomView:(GCustomNotification *) customView
{
    UIActivityIndicatorView *indicatorView = [customView createActivityIndicator];
    UILabel *messageView = (UILabel *)[customView viewWithTag:kViewTag_MessageLabel];
    CGSize sz = [messageView.text sizeWithFont:messageView.font];

    // The alignment of the text is not centered for easier placement of the UIActivityIndicatorView
    messageView.textAlignment = UITextAlignmentRight;
    float widthWithIndicator = sz.width + indicatorView.frame.size.width * 1.2f;
    float centeredX = (customView.frame.size.width - widthWithIndicator) / 2.0f;
    float centeredIndicatorY = (messageView.frame.size.height - indicatorView.frame.size.height) / 2.0f;

    // Adjust the Activity Indicator Y position so that it's centered with the Message Label
    indicatorView.frame = CGRectMake(indicatorView.frame.origin.x,
                                     centeredIndicatorY,
                                     indicatorView.frame.size.width,
                                     indicatorView.frame.size.height);

    // Adjust the Message View Frame to our indicator
    messageView.frame = CGRectMake(centeredX,
                                   messageView.frame.origin.y,
                                   widthWithIndicator,
                                   sz.height);

    customView.activityIndicator = indicatorView;
    [messageView addSubview:indicatorView];
}

+ (GCustomNotification *) notificationWithMessage:(NSString *) message forTotalTime:(NSTimeInterval) interval
{
    GCustomNotification *customView = [[GCustomNotification alloc] initWithMessage:message andDismissAfterTime:interval];
    return customView;
}

+ (GNotificationAppearance *) sharedAppearance
{
    if (!_sharedAppearance) {
        _sharedAppearance = [GAppearanceFactory defaultAppearance];
    }

    return _sharedAppearance;
}

#pragma mark -
#pragma mark Non Static Methods

- (id) initWithMessage:(NSString *) message andDismissAfterTime:(NSTimeInterval) interval
{
    if (!self.notificationAppearance) {
        self.notificationAppearance = [GCustomNotification sharedAppearance];
    }
    
    if (self = [super init]) {
        // First we create the UILabelView in order to match the Size
        UILabel *label = [[UILabel alloc] init];
        label.text = message;
        label.font = _notificationAppearance.font;
        label.textColor = _notificationAppearance.textColor;
        label.textAlignment = _notificationAppearance.textAlignment;
        label.shadowOffset = _notificationAppearance.shadowOffset;
        label.shadowColor = _notificationAppearance.shadowColor;
        label.backgroundColor = [UIColor clearColor];
        label.tag = kViewTag_MessageLabel;

        CGSize sz = [label.text sizeWithFont:label.font];

        // Now that we have the exact label size we can give our notification view a proper size
        _notificationView = [[UIView alloc] init];
        _notificationView.frame = CGRectMake(0, 0, sz.width * 2.0f, sz.height * 2.0f);
        super.frame = _notificationView.frame;

        // Adjust our label to the Notification View Frame
        label.frame = CGRectMake(0,
                                 (_notificationView.frame.size.height / 2.0f - sz.height / 2.0),
                                 _notificationView.frame.size.width,
                                 sz.height);

        // Perform View Customization
        _notificationView.backgroundColor = _notificationAppearance.backgroundColor;
        _notificationView.alpha = 0.0;
        _notificationView.layer.cornerRadius = _notificationAppearance.cornerRadius;
        _notificationView.layer.masksToBounds = YES;
        _notificationView.tag = kViewTag_NotificationFrame;
        [self addSubview:_notificationView];
        [_notificationView addSubview:label];

        [UIView animateWithDuration:0.4
                         animations:^ {_notificationView.alpha = _notificationAppearance.backgroundAlpha;}
                         completion:nil];

        if (interval != kNoDismissInterval) {
            [self performSelector:@selector(dismiss:) withObject:_notificationView afterDelay:interval];
        }
    }

    return self;
}

- (UIActivityIndicatorView *) createActivityIndicator
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:_notificationAppearance.activityIndicatorStyle];
    activityIndicator.tag = kViewTag_ActivityIndicator;
    activityIndicator.hidesWhenStopped = YES;
    [activityIndicator startAnimating];
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

- (GNotificationAppearance *) appearance
{
    if (!_notificationAppearance) {
        _notificationAppearance = _sharedAppearance = [GAppearanceFactory defaultAppearance];
    }
    return _notificationAppearance;
}

- (void) setAppearance:(GNotificationAppearance *)appearance
{
    _notificationAppearance = appearance;
}

@end
