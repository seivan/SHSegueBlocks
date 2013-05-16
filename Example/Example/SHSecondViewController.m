//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"

@interface SHSecondViewController ()
-(IBAction)tapProgUnwind:(id)sender;

@end

@implementation SHSecondViewController
@synthesize name;

-(IBAction)tapProgUnwind:(id)sender; {
  //[self performSegueWithIdentifier:@"unwinder" sender:self];
  [self SH_performSegueWithIdentifier:@"unwinder" withUserInfo:@{@"date" : [NSDate date]}];
}


-(void)viewDidLoad;{
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  NSLog(@"Sent here by identifier; %@", self.name);
}



@end
