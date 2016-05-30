//
//  NTItemComponentQuote.h
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/30/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>
#import "NTItem.h"
#import "NTItemContext.h"

@interface NTItemComponentQuote : CKCompositeComponent

+ (instancetype)newWithItem:(NTItem *)item context:(NTItemContext *)context;

@end
