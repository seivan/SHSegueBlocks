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

-(IBAction)tapProgUnwind:(id)sender; {
  [self performSegueWithIdentifier:@"unwinder" sender:self];
}


-(void)viewDidLoad;{
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  NSLog(@"SHSecondViewController prepareForSegue %@ - %@", sender, segue);
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender NS_AVAILABLE_IOS(6_0); {
  NSLog(@"SHSecondViewController shouldPerformSegueWithIdentifier %@ - %@", sender, identifier);
  return YES;
  
}// Invoked immediately prior to initiating a segue. Return NO to prevent the segue from firing. The default implementation returns YES. This method is not invoked when -performSegueWithIdentifier:sender: is used.

// View controllers will receive this message during segue unwinding. The default implementation returns the result of -respondsToSelector: - controllers can override this to perform any ancillary checks, if necessary.
//- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender NS_AVAILABLE_IOS(6_0); {
//  NSLog(@"SHSecondViewController canPerformUnwindSegueAction %@ %@ - %@", NSStringFromSelector(action), sender, fromViewController);
//  return YES;
//}

// Custom containers should override this method and search their children for an action handler (using -canPerformUnwindSegueAction:fromViewController:sender:). If a handler is found, the controller should return it. Otherwise, the result of invoking super's implementation should be returned.
//- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender NS_AVAILABLE_IOS(6_0); {
//  NSLog(@"SHSecondViewController viewControllerForUnwindSegueAction %@ %@ - %@", NSStringFromSelector(action), sender, fromViewController);
//}
//
//// Custom container view controllers should override this method and return segue instances that will perform the navigation portion of segue unwinding.
//- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0); {
//  NSLog(@"SHSecondViewController segueForUnwindingToViewController %@ %@ - %@", identifier, fromViewController, toViewController);
//}
//



@end
