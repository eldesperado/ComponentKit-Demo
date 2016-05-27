//
//  NTItemActionsComponent.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/27/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTItemActionsComponent.h"

@implementation NTItemActionsComponent

+ (instancetype)newWithItem:(NTItem *)item context:(NTItemContext *)context {
    return [super newWithComponent:
            [CKStackLayoutComponent
             newWithView:{}
             size:{
                 .height = 40
             }
             style:{
                 .direction = CKStackLayoutDirectionHorizontal,
                 .justifyContent = CKStackLayoutJustifyContentEnd,
                 .spacing = 20.0
             }
             children:{
                 {
                     .component = buttonComponentWithTitle(@"Share", @selector(share:)),
                     .alignSelf = CKStackLayoutAlignSelfCenter,
                 },
                 {
                     .component = buttonComponentWithTitle(@"Read", @selector(read:)),
                     .alignSelf = CKStackLayoutAlignSelfCenter,
                     .spacingAfter = 20.0
                 },
             }]];
}

static CKButtonComponent *buttonComponentWithTitle(NSString *title, CKComponentAction action)
{
    return [CKButtonComponent
            newWithTitles:{
                { UIControlStateNormal, title }
            } titleColors:{
                { UIControlStateNormal, [UIColor colorWithRed:80/255 green:188/255 blue:182/255 alpha:1] },
                { UIControlStateHighlighted, [UIColor colorWithRed:80/255 green:188/255 blue:182/255 alpha:0.3] }
            }
            images:{}
            backgroundImages:{}
            titleFont:[UIFont systemFontOfSize:13]
            selected:NO
            enabled:YES
            action:action
            size:{.height = 30.0}
            attributes:{}
            accessibilityConfiguration:{}];
}


#pragma mark - Actions

- (void)share:(CKButtonComponent *)sender
{
    NSLog(@"Share Button did touch!");
}

- (void)read:(CKButtonComponent *)sender
{
    NSLog(@"Read Button did touch!");
}


@end
