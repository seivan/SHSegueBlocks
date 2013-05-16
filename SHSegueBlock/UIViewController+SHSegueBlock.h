//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

typedef void(^SHSegueBlockPrepareForSegue)(UIStoryboardSegue *theSegue);
//typedef void(^SHOmniAuthAccountsListHandler)(NSArray * accounts, SHOmniAuthAccountPickerHandler pickAccountBlock);

@interface UIViewController (SHSegueBlock)
- (void)SH_performSegueWithIdentifier:(NSString *)identifier
           andPrepareForSegueBlock:(SHSegueBlockPrepareForSegue)theBlock;
@end
