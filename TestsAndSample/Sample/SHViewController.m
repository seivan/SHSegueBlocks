//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import <SHSegueBlocks.h>
#import <SHObjectUserInfo.h>

#import "SHViewController.h"
@interface SHViewController ()
-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;
@end

@implementation SHViewController
@synthesize name;

-(void)viewDidLoad;{
  [super viewDidLoad];
  
}

-(IBAction)performSegue:(id)sender; {
  [self SH_performSegueWithIdentifier:@"first" andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    id<SHExampleProtocol> destionationController =   theSegue.destinationViewController;
    destionationController.name = theSegue.identifier;
  }];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  if(self.SH_userInfo.count > 0)
    NSLog(@"Sent here by unwinding programatically and using userInfo; %@", self.SH_userInfo);
  else
    NSLog(@"Sent here by unwinding through IB and no userInfo; %@", self.SH_userInfo);


}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;{

}


@end
