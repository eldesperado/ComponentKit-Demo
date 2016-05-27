//
//  NTItemsPage.h
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/26/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTItemsPage : NSObject

@property(strong, nonatomic, readonly) NSArray *items;
@property(assign, nonatomic, readonly) NSInteger position;

- (instancetype)initWithItems:(NSArray *)items position:(NSInteger)position;

@end
