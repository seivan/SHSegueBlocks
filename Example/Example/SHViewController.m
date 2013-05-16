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
  NSLog(@"%@",self.SH_userInfo);
  if(self.SH_userInfo[@"name"]) NSLog(@"Sent here by unwinding and using userInfo; %@", self.SH_userInfo[@"name"]);
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

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
//  NSLog(@"SHViewController prepareForSegue ");
//}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender NS_AVAILABLE_IOS(6_0); {
//   NSLog(@"SHViewController shouldPerformSegueWithIdentifier");
  return YES;
  
}// Invoked immediately prior to initiating a segue. Return NO to prevent the segue from firing. The default implementation returns YES. This method is not invoked when -performSegueWithIdentifier:sender: is used.

// View controllers will receive this message during segue unwinding. The default implementation returns the result of -respondsToSelector: - controllers can override this to perform any ancillary checks, if necessary.
- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender NS_AVAILABLE_IOS(6_0); {
//     NSLog(@"SHViewController canPerformUnwindSegueAction %@", NSStringFromSelector(action));
  return YES;
}

@end
