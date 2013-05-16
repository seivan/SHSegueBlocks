//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

typedef void(^SHPrepareForSegue)(UIStoryboardSegue *theSegue);
typedef void(^SHPrepareForSegueWithUserInfo)(NSMutableDictionary * userInfo);
//typedef void(^SHOmniAuthAccountsListHandler)(NSArray * accounts, SHOmniAuthAccountPickerHandler pickAccountBlock);

@interface UIViewController (SHSegueBlock)
@property(nonatomic,strong) NSMutableDictionary * userInfo;

-(void)SH_performSegueWithIdentifier:(NSString *)identifier
           andPrepareForSegueBlock:(SHPrepareForSegue)theBlock;

//I don't recomend using this - it's stupid. If you need your destination controller to have certain properties, use a fucking protocol.
-(void)SH_performSegueWithIdentifier:(NSString *)identifier
              withUserInfo:(NSDictionary *)theUserInfo;

-(void)SH_memoryDebugger;
@end
