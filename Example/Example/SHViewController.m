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

-(void)viewDidLoad;{
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    if (self.navigationController) {
      [self performSegueWithIdentifier:@"push" sender:self];
    }

  });
}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;{
    NSLog(@"SHViewController UNWINDER:  ");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  NSLog(@"SHViewController prepareForSegue ");
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender NS_AVAILABLE_IOS(6_0); {
   NSLog(@"SHViewController shouldPerformSegueWithIdentifier");
  return YES;
  
}// Invoked immediately prior to initiating a segue. Return NO to prevent the segue from firing. The default implementation returns YES. This method is not invoked when -performSegueWithIdentifier:sender: is used.

// View controllers will receive this message during segue unwinding. The default implementation returns the result of -respondsToSelector: - controllers can override this to perform any ancillary checks, if necessary.
- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender NS_AVAILABLE_IOS(6_0); {
     NSLog(@"SHViewController canPerformUnwindSegueAction %@", NSStringFromSelector(action));
  return YES;
}

// Custom containers should override this method and search their children for an action handler (using -canPerformUnwindSegueAction:fromViewController:sender:). If a handler is found, the controller should return it. Otherwise, the result of invoking super's implementation should be returned.
- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender NS_AVAILABLE_IOS(6_0); {
       NSLog(@"viewControllerForUnwindSegueAction %@ ", NSStringFromSelector(action));
}

// Custom container view controllers should override this method and return segue instances that will perform the navigation portion of segue unwinding.
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0); {
         NSLog(@"segueForUnwindingToViewController %@", identifier);
}




@end
