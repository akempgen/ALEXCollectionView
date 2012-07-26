//
//  ALEXAppDelegate.m
//  ALEXCollectionView
//
//  Created by Alexander Kempgen on 25.07.12.
//  Copyright (c) 2012 Alexander Kempgen. All rights reserved.
//

#import "ALEXAppDelegate.h"



@interface ALEXAppDelegate ()


@end


@implementation ALEXAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	
	[self.collectionView reloadData];
}


-(NSInteger)collectionView:(ALEXCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 5;
}

-(NSView *)collectionView:(ALEXCollectionView *)collectionView viewForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [collectionView makeViewWithIdentifier:@"cell" owner:self];
}


- (NSInteger)numberOfSectionsInCollectionView:(ALEXCollectionView *)collectionView
{
	return 2;
}

- (NSView *)collectionView:(ALEXCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0., 0., 300., 30.)];
	textField.stringValue = [NSString stringWithFormat:@"Section %@", indexPath];
	[textField sizeToFit];
	return textField;
}


@end
