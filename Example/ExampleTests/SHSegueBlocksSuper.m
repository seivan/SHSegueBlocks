//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//



#import "SHSegueBlocksSuper.h"



@implementation SHSegueBlocksSuper

-(void)setUp; {
  [super setUp];
  UINavigationController * navCon = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;

  self.firstVc = navCon.viewControllers.SH_firstObject;
  self.navCon  = navCon;
  self.firstSegueIdentifier = @"first";
}

-(void)tearDown; {
  [super tearDown];
  self.firstVc = nil;
  self.navCon = nil;
}
@end

