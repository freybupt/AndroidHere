//
//  OverlayViewController.m
//  OverlayViewTester
//
//  Created by Jason Job on 09-12-10.
//  Copyright 2009 Jason Job. All rights reserved.
//

#import "OverlayViewController.h"
#import "OverlayView.h"


@implementation OverlayViewController


- (void) viewDidAppear:(BOOL)animated {
	OverlayView *overlay = [[OverlayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
	
	// Create a new image picker instance:
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	
	// Set the image picker source:
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        picker.showsCameraControls = YES;
        
        picker.delegate = self;
        
        picker.allowsImageEditing = NO;
        
        picker.navigationBarHidden=YES;
        
        // Insert the overlay:
        picker.cameraOverlayView = overlay;
        
        
        // Show the picker:
        [self presentModalViewController:picker animated:YES];

        
    } else
        
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry! No Camera" 
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
    
}


- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// After saving iamge, dismiss camera
	[self dismissModalViewControllerAnimated:YES];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    
	// Unable to save the image  
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                           message:@"Unable to save image to Photo Album." 
                                          delegate:self cancelButtonTitle:@"Ok" 
                                 otherButtonTitles:nil];
	else // All is well
        alert = [[UIAlertView alloc] initWithTitle:@"Success" 
                                           message:@"Image saved to Photo Album." 
                                          delegate:self cancelButtonTitle:@"Ok" 
                                 otherButtonTitles:nil];
    
    
    [alert show];
    [alert release];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIWindow *theScreen = [[UIApplication sharedApplication].windows objectAtIndex:0];
    CGSize picturesize = CGSizeMake(320, 420);
	UIGraphicsBeginImageContext(picturesize);
	[[theScreen layer] renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    
	// Access the uncropped image from info dictionary
//	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
 //   UIImage *screenshot = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
	// Save image
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    // Save image
    UIImageWriteToSavedPhotosAlbum(screenshot, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
	[picker release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
