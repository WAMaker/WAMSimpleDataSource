//
//  WAMCellInfo+Private.m
//  WAMSimpleDataSource
//
//  Created by wamaker on 2016/12/17.
//  Copyright © 2016年 wamaker. All rights reserved.
//

#import "WAMCellInfo+Private.h"

@implementation WAMCellInfo (Private)

- (BOOL)valid {
    return self.reuseIdentifier || self.cell;
}

@end
