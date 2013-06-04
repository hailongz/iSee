//
//  SESourceDataController.m
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SESourceDataController.h"

@implementation SESourceDataController


-(VTItemViewController *) vtContainerView:(VTContainerView *) containerView itemViewAtIndex:(NSInteger) index frame:(CGRect) frame{
    
    id data = [self.dataSource dataObjectAtIndex:index];

    NSString * itemNib = [data valueForKeyPath:@"SourceItemNib"];
    
    VTItemViewController * itemViewController = [containerView dequeueReusableItemViewWithIdentifier:itemNib];
    
    if(itemViewController == nil){
        
        Class clazz = NSClassFromString(self.itemViewClass);
        
        if(clazz == nil){
            clazz = [VTItemViewController class];
        }
        
        itemViewController = [[clazz alloc] initWithNibName:itemNib bundle:[data valueForKeyPath:@"bundle"]] ;
        [itemViewController setReuseIdentifier:itemNib];
        [itemViewController setDelegate:self];
        
    }
    
    UIView * itemView = [itemViewController view];
    
    [itemViewController setContext:self.context];
    
    [itemViewController setDataItem:data];
    
    [itemViewController.dataSource cancel];
    [itemViewController.dataSource reloadData];
    
    [self loadImagesForView:itemView];
    
    return itemViewController;
}

-(CGSize) vtContainerLayout:(VTContainerLayout *)containerLayout itemSizeAtIndex:(NSInteger)index{
    return CGSizeMake(0, 120);
}



@end
