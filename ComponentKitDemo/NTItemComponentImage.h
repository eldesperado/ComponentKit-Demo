//
//  NTItemConponentImage.h
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/30/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTItem.h"
#import "NTItemContext.h"
#import <ComponentKit/ComponentKit.h>

@interface NTItemComponentImage : CKCompositeComponent

+ (instancetype)newWithItem:(NTItem *)item context:(NTItemContext *)context;

@end
