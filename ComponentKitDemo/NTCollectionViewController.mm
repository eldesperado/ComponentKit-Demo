//
//  NTCollectionViewController.m
//  ComponentKitDemo
//
//  Created by CPU11739-local on 5/27/16.
//  Copyright © 2016 CPU11739-local. All rights reserved.
//

#import "NTCollectionViewController.h"
#import "NTItemContext.h"
#import "NTItemModelController.h"
#import "NTNetworkImageDownloader.h"
#import <ComponentKit/ComponentKit.h>
#import "NTItemComponent.h"
#import "NTItemsPage.h"

@interface NTCollectionViewController () <CKComponentProvider, UICollectionViewDelegateFlowLayout>

@property(strong, nonatomic) CKCollectionViewDataSource *dataSource;
@property(strong, nonatomic)
CKComponentFlexibleSizeRangeProvider *sizeRangeProvider;
@property(strong, nonatomic) NTItemModelController *itemModelController;
@property(strong, nonatomic) NTNetworkImageDownloader *networkImageDownloader;

@end

@implementation NTCollectionViewController

static NSString *const reuseIdentifier = @"Cell";

#pragma mark - Initialization
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self == nil) {
        return self;
    }
    
    _sizeRangeProvider = [CKComponentFlexibleSizeRangeProvider
                          providerWithFlexibility:CKComponentSizeRangeFlexibleHeight];
    _itemModelController = [[NTItemModelController alloc] init];
    _networkImageDownloader = [[NTNetworkImageDownloader alloc] init];
    
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup Collection View
    self.collectionView.delegate = self;
    
    // Set Title
    self.title = @"UNSPLASH";
    
    // Create a new Item Context
    NTItemContext *context = [[NTItemContext alloc]
                              initWithImageDownloader:self.networkImageDownloader];
    
    // Create a new Datasource
    self.dataSource = [[CKCollectionViewDataSource alloc]
                       initWithCollectionView:self.collectionView
                       supplementaryViewDataSource:nil
                       componentProvider:[self class]
                       context:context
                       cellConfigurationFunction:nil];
    
    // Insert a new section
    CKArrayControllerSections sections;
    sections.insert(0);
    [_dataSource enqueueChangeset:{sections, {}} constrainedSize:{}];
    [self _enqueuePage:[_itemModelController fetchNewQuotesPageWithCount:3]];
}

#pragma mark - Fetching Items
- (void)_enqueuePage:(NTItemsPage *)itemPage
{
    NSArray *items = itemPage.items;
    NSInteger position = itemPage.position;
    
    // Convert the array of quotes to a valid changeset
    CKArrayControllerInputItems inputItems;
    for (NSInteger i = 0; i < [items count]; i++) {
        inputItems.insert([NSIndexPath indexPathForRow:position + i inSection:0], items[i]);
    }
    [_dataSource enqueueChangeset:{{}, inputItems}
                  constrainedSize:[_sizeRangeProvider sizeRangeForBoundingSize:self.collectionView.bounds.size]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_dataSource sizeForItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_dataSource announceWillAppearForItemInCell:cell];
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_dataSource announceDidDisappearForItemInCell:cell];
}


#pragma mark - CKComponentProvider

+ (CKComponent *)componentForModel:(NTItem *)item context:(NTItemContext *)context
{
    return [NTItemComponent newWithItem:item context:context];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if( scrollView.contentSize.height == 0 ) {
        return ;
    }
    
    if (scrolledToBottomWithBuffer(scrollView.contentOffset, scrollView.contentSize, scrollView.contentInset, scrollView.bounds)) {
        [self _enqueuePage:[_itemModelController fetchNewQuotesPageWithCount:4]];
    }
}

static BOOL scrolledToBottomWithBuffer(CGPoint contentOffset, CGSize contentSize, UIEdgeInsets contentInset, CGRect bounds)
{
    CGFloat buffer = CGRectGetHeight(bounds) - contentInset.top - contentInset.bottom;
    const CGFloat maxVisibleY = (contentOffset.y + bounds.size.height);
    const CGFloat actualMaxY = (contentSize.height + contentInset.bottom);
    return ((maxVisibleY + buffer) >= actualMaxY);
}

@end
