//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs

typedef void(^SHPrepareForSegue)(UIStoryboardSegue *theSegue);
typedef void(^SHPrepareForSegueWithUserInfo)(NSMutableDictionary * userInfo);


@interface UIViewController (SHSegueBlock)
#pragma mark -
#pragma mark Properties

@property(nonatomic,strong) NSMutableDictionary * SH_userInfo;

#pragma mark -
#pragma mark Segue Performers

#pragma mark -
#pragma mark Awesome

-(void)SH_performSegueWithIdentifier:(NSString *)identifier
           andPrepareForSegueBlock:(SHPrepareForSegue)theBlock;

#pragma mark -
#pragma mark For losers
//I don't recomend using this - it's stupid. If you need your destination controller to have certain properties, use a fucking protocol.
-(void)SH_performSegueWithIdentifier:(NSString *)identifier
              withUserInfo:(NSDictionary *)theUserInfo;


@end
