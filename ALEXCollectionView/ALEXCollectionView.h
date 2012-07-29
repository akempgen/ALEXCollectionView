//
//  ALEXCollectionView.h
//  ALEXCollectionView
//
//  Created by Alexander Kempgen on 25.07.12.
//  Copyright (c) 2012 Alexander Kempgen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ALEXView.h"

@protocol ALEXCollectionViewDataSource;


@interface ALEXCollectionView : ALEXView

@property (unsafe_unretained) IBOutlet id <ALEXCollectionViewDataSource> dataSource;

- (void)reloadData;
- (id)makeViewWithIdentifier:(NSString *)identifier owner:(id)owner;
@end



@protocol ALEXCollectionViewDataSource <NSObject>


@required

- (NSInteger)collectionView:(ALEXCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

- (NSView *)collectionView:(ALEXCollectionView *)collectionView viewForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInCollectionView:(ALEXCollectionView *)collectionView;

- (NSView *)collectionView:(ALEXCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

@end
