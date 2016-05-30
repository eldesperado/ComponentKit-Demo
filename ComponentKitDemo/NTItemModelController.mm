//
//  NTItemModelController.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/27/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTItemModelController.h"
#import "NTItem.h"
#import "NTItemComponentType.h"

@implementation NTItemModelController
{
    NSInteger _numberOfItems;
}

- (instancetype)init
{
    if (self = [super init]) {
        _numberOfItems = 0;
    }
    return self;
}

#pragma mark - Random
- (NTItemsPage *)fetchNewQuotesPageWithCount:(NSInteger)count
{
    NSAssert(count >= 1, @"Count should be a positive integer");
    NSArray * items = generateItems(count);
    NTItemsPage *quotesPage = [[NTItemsPage alloc] initWithItems:items position:_numberOfItems];
    _numberOfItems += count;
    return quotesPage;
}

#pragma mark - Random Quote Generation

static NSArray *generateItems(NSInteger count)
{
    NSMutableArray *_items = [NSMutableArray new];
    

    for (NSUInteger i = 0; i< count; i++) {
        NSString *title = generateTitle();
        NSString *imageURLString = [NSString stringWithFormat:@"https://unsplash.it/500/300?image=%d", arc4random_uniform((uint32_t)30)];
        NTItem *item = [[NTItem alloc] initWithTitle:title
                                      imageURLString:imageURLString
                                               style:generateStyle(i)];
        
        [_items addObject:item];
    }
    return _items;
}

static NTItemComponentType generateStyle(NSUInteger index)
{
    switch (index % 2) {
        case 0:
            return NTItemComponentTypeImage;
        case 1:
            return NTItemComponentTypeQuote;
        default:
            return NTItemComponentTypeImage;
    }
}

static NSString *generateTitle()
{
    NSArray *titles = titleList();
    return titles[arc4random_uniform((uint32_t)[titles count])];
}

static NSArray *titleList()
{
    static NSArray *titles;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        titles = @[
                   @"Foe Of Wind",
                   @"Foreigner Of Dread",
                   @"Criminals Without A Goal",
                   @"Descendants Without Flaws",
                   @"Foes And Foes",
                   @"Traitor Of Exploration",
                   @"Martians Of Stardust",
                   @"Captains Of The Past",
                   @"Moon Of Men's Legacy",
                   @"Guardians Of The Moon",
                   @"Obliteration Of Our Destiny",
                   @"Chase Of Darkness",
                   @"Broken The End Of The Sun",
                   @"Celebrating A Robot Takeover",
                   @"Harlequin Kicked Me Out",
                   @"Doctor And Buffoon",
                   @"Pig And Buffoon",
                   @"Tricks Exploit",
                   @"Fools Program"
                   ];
    });
    return titles;
}

@end
