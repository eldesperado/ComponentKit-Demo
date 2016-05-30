//
//  NTItemComponentQuote.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/30/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTItemComponentQuote.h"
#import "NTOverlayBackgroundComponent.h"
#import "NTItemActionsComponent.h"

@implementation NTItemComponentQuote
+ (instancetype)newWithItem:(NTItem *)item context:(NTItemContext *)context {
    CKComponentScope scope(self, item.itemId);
    
    return [super newWithComponent:
            [CKStackLayoutComponent
             newWithView:{
                 [UIView class],
                 {{@selector(setBackgroundColor:), [UIColor whiteColor]}}
             }
             size:{}
             style:{
                 .direction = CKStackLayoutDirectionVertical,
                 .alignItems = CKStackLayoutAlignItemsStretch,
             }
             children:{
                 {
                     .component = backgroundComponent(item, context)
                 },
                 {.component = [NTItemActionsComponent newWithItem:item context:context]},
                 {.component = hairlineComponent()},
             }]
            ];
}

static CKComponent *hairlineComponent()
{
    return [CKComponent
            newWithView:{
                [UIView class],
                {{@selector(setBackgroundColor:), [UIColor lightGrayColor]}}
            }
            size:{.height = 1/UIScreen.mainScreen.scale * 2}];
}

static CKComponent *backgroundComponent(NTItem *item, NTItemContext *context)
{
    return [CKBackgroundLayoutComponent
            newWithComponent:
            [CKStackLayoutComponent
             newWithView:{}
             size:{
                 .minHeight = 200
             }
             style:{
                 .direction = CKStackLayoutDirectionVertical,
                 .alignItems = CKStackLayoutAlignItemsStretch,
                 .justifyContent = CKStackLayoutJustifyContentCenter,
             }
             children:{
                 {
                     [CKLabelComponent
                      newWithLabelAttributes:{
                          .string = item.title,
                          .font = [UIFont fontWithName:@"Baskerville" size:30],
                          .color = [UIColor whiteColor],
                          .alignment = NSTextAlignmentCenter,
                      }
                      viewAttributes:{
                          {@selector(setBackgroundColor:), [UIColor clearColor]},
                          {@selector(setUserInteractionEnabled:), @NO},
                      }
                      size:{}],
                     .alignSelf = CKStackLayoutAlignSelfCenter,
                 },
             }]
            background:overlayBackgroundComponent(item, context)];
}

static CKComponent *overlayBackgroundComponent(NTItem *item, NTItemContext *context)
{
    return [NTOverlayBackgroundComponent
            newWithItem:item context:context];
}

@end
