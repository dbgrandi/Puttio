//
//  LocalBrowsingViewController.h
//  Puttio
//
//  Created by David Grandinetti on 6/10/12.
//  Copyright (c) 2012 ortatherox.com. All rights reserved.
//

#import "BrowsingViewController.h"

@interface LocalBrowsingViewController : BrowsingViewController <GMGridViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *noItemsView;
@property (weak, nonatomic) IBOutlet UILabel *deviceStoredLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceSpaceLeftLabel;

@end
