//
//  AppDelegate.m
//  tableviewdropdowncell
//
//  Created by wyj on 2016/12/17.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AppDelegate.h"
#import "TableviewDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *tableView;

@property (strong) TableviewDelegate* tableviewDelegate;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [_tableView reloadData];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
