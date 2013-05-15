//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 4/10/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

typedef void(^SHShouldPerformSegueuBlock)(UIStoryboard * theStoryboard);
typedef void(^SHPrepareForSegueuBlock)(UIStoryboard * theStoryboard);
//typedef void(^SHOmniAuthAccountsListHandler)(NSArray * accounts, SHOmniAuthAccountPickerHandler pickAccountBlock);
@interface UIViewController (SHSegueBlock)
-(void)SH_performSegueWithIdentifier:(NSString *)theIdentifier shouldPerformSegue:(SHShouldPerformSegueuBlock)theSegueBloc;
@end
