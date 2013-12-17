//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import <SHSegueBlocks.h>
#import <SHObjectUserInfo.h>
@interface SHSecondViewController ()

@end

@implementation SHSecondViewController
@synthesize name;


-(IBAction)performSegue:(id)sender; {
  [self SH_performSegueWithIdentifier:@"second" withUserInfo:@{@"date" : [NSDate date]}];
}

-(void)viewDidLoad;{
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  NSLog(@"Sent here by identifier; %@", self.name);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  UIViewController * destionationVc = segue.destinationViewController;
  destionationVc.SH_userInfo = nil;

  if([self SH_handlesBlockForSegue:segue])
    NSLog(@"Performed segueue programatically user info: %@", destionationVc.SH_userInfo);
  else
    NSLog(@"Performed segueue via IB");
  
  
}


@end
