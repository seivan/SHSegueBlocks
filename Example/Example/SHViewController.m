//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//




#import "SHViewController.h"
@interface SHViewController ()
-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;
@end

@implementation SHViewController
@synthesize name;
-(void)viewDidLoad;{
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  if(self.SH_userInfo[@"date"]) NSLog(@"Sent here by unwinding and using userInfo; %@", self.SH_userInfo[@"date"]);
  [super viewDidAppear:animated];
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    if (self.navigationController) {
      //[self performSegueWithIdentifier:@"push" sender:self];
      [self SH_performSegueWithIdentifier:@"push" andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
        id<SHExampleProtocol> destionationController =   theSegue.destinationViewController;
        destionationController.name = theSegue.identifier;
      }];
    }

  });
}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;{
    NSLog(@"SHViewController UNWINDER:  ");
}


@end
