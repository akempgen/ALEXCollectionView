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
	return 3;
}

-(NSView *)collectionView:(ALEXCollectionView *)collectionView viewForItemAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSTableCellView *tableCellView =  [collectionView makeViewWithIdentifier:@"tablecell" owner:self];
	
	NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[NSColor greenColor] endingColor:[NSColor yellowColor]];
	
	[[tableCellView subviews][0] setGradient:gradient];
	[[tableCellView subviews][0] setAngle:([indexPath indexAtPosition:indexPath.length-1]%2 == 0?0:180)];
	
	return tableCellView;
	
}


- (NSInteger)numberOfSectionsInCollectionView:(ALEXCollectionView *)collectionView
{
	return 2;
}

- (NSView *)collectionView:(ALEXCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	
	NSView* view = [collectionView makeViewWithIdentifier:@"group" owner:self];

	return view;
}


@end
