//
//  NTItemConponentImage.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/30/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTItemComponentImage.h"
#import "NTItemActionsComponent.h"
#import <UIKit/UIKit.h>

@implementation NTItemComponentImage

+ (instancetype)newWithItem:(NTItem *)item context:(NTItemContext *)context {
    CKComponentScope scope(self, item.itemId);
    
    return [super newWithComponent:
            [CKBackgroundLayoutComponent
             newWithComponent:
             [CKStackLayoutComponent
              newWithView:{}
              size:{}
              style:{
                  .direction = CKStackLayoutDirectionVertical,
                  .alignItems = CKStackLayoutAlignItemsStretch
              }
              children:{
                  {.component =
                      [CKInsetComponent
                       newWithInsets:{.left = 20.0, .right = 20.0, .top = 10.0}
                       component:
                       [CKLabelComponent
                        newWithLabelAttributes:{
                            .string = item.title,
                            .font = [UIFont systemFontOfSize:17.0]
                        }
                        viewAttributes:{
                            {@selector(setBackgroundColor:), [UIColor clearColor]},
                            {@selector(setUserInteractionEnabled:), @NO},
                        }
                        size:{}]]
                  },
                  {.component = featuredImageComponent(item, context)},
                  {.component = [NTItemActionsComponent newWithItem:item context:context]},
                  {.component = hairlineComponent()},
              }]
             background:backgroundComponent()]];
}

static CKComponent *featuredImageComponent(NTItem *item, NTItemContext *context)
{
    return [CKInsetComponent
            newWithInsets:{ .left = 0.0, .right = 0.0, .top = 10.0 }
            component:
            [CKNetworkImageComponent
             newWithURL:item.imageURL
             imageDownloader:context.imageDownloader
             scenePath:nil
             size:{
                 .height = 300
             }
             options:{
                 .defaultImage = defaultImage()
             }
             attributes:{}]];
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

static CKComponent *backgroundComponent()
{
    return [CKComponent
            newWithView:{
                [UIView class],
                {{@selector(setBackgroundColor:), [UIColor whiteColor]}}
            }
            size:{}];
}

static UIImage *defaultImage()
{
    static UIImage *defaultImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize size = CGSizeMake(100.0, 100.0);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextFillRect(context, CGRectMake(0.f, 0.f, size.width, size.height));
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        defaultImage = image;
    });
    
    return defaultImage;
}

@end
