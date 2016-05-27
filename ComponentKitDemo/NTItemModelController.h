//
//  NTItemModelController.h
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/27/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTItemsPage.h"

@interface NTItemModelController : NSObject

- (NTItemsPage *)fetchNewQuotesPageWithCount:(NSInteger)count;

@end
