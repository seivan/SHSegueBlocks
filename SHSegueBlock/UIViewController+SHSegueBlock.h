//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

typedef void(^SHPrepareForSegue)(UIStoryboardSegue *theSegue);
typedef void(^SHPrepareUserInfoForSegue)(NSMutableDictionary * userInfo);
//typedef void(^SHOmniAuthAccountsListHandler)(NSArray * accounts, SHOmniAuthAccountPickerHandler pickAccountBlock);

@interface UIViewController (SHSegueBlock)
@property(nonatomic,strong) NSMutableDictionary * userInfo;
- (void)SH_performSegueWithIdentifier:(NSString *)identifier
           andPrepareForSegueBlock:(SHPrepareForSegue)theBlock;
- (void)SH_performSegueWithIdentifier:(NSString *)identifier
              andPrepareUserInfoForSegueBlock:(SHPrepareUserInfoForSegue)theBlock;

@end
