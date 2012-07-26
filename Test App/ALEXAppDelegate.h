//
//  ALEXAppDelegate.h
//  ALEXCollectionView
//
//  Created by Alexander Kempgen on 25.07.12.
//  Copyright (c) 2012 Alexander Kempgen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ALEXCollectionView.h"


@interface ALEXAppDelegate : NSObject <NSApplicationDelegate, ALEXCollectionViewDataSource>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet ALEXCollectionView *collectionView;


@end
