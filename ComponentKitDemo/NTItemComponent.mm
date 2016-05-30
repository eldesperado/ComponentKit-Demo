//
//  NTItemComponent.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/27/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTItemComponent.h"
#import "NTItemActionsComponent.h"
#import "NTItemComponentImage.h"
#import "NTItemComponentQuote.h"
#import <UIKit/UIKit.h>

@implementation NTItemComponent

+ (instancetype)newWithItem:(NTItem *)item context:(NTItemContext *)context {
    return [super newWithComponent:itemComponent(item, context)];
}

static CKComponent *itemComponent(NTItem *item, NTItemContext *context)
{
    switch (item.style) {
        case NTItemComponentTypeImage:
            return [NTItemComponentImage
                    newWithItem:item context:context];
        case NTItemComponentTypeQuote:
            return [NTItemComponentQuote
                    newWithItem:item context:context];
    }
}@end
