//
//  TableviewDelegate.h
//  tableviewdropdowncell
//
//  Created by wyj on 2016/12/17.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TableviewDelegate : NSObject<NSTableViewDataSource, NSTableViewDelegate>{
    
    @private
    NSMutableArray  *tableContent;
    NSInteger       dropdownItem;
    
}

@end
