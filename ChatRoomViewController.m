//
//  ChatRoomViewController.m
//  Chatty
//
//  Copyright (c) 2009 Peter Bakhyryev <peter@byteclub.com>, ByteClub LLC
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.

#import "ChatRoomViewController.h"
#import "ChattyAppDelegate.h"
#import "UITextView+Utils.h"


@implementation ChatRoomViewController

@synthesize chatRoom;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        //init
        self.title = @"Chat Room";
    }
    
    return self;
}

// After view shows up, start the room
-(void)viewDidAppear:(BOOL)animated
{
  if ( chatRoom != nil ) {
    chatRoom.delegate = self;
    [chatRoom start];
  }
  
  [input becomeFirstResponder];
}

// User decided to exit room
-(void)viewDidDisappear:(BOOL)animated
{
    // Close the room
    [chatRoom stop];
    
    // Remove keyboard
    [input resignFirstResponder];
    
    // Erase chat
    chat.text = @"";
    
}

// Cleanup


// We are being asked to display a chat message
- (void)displayChatMessage:(NSString*)message fromUser:(NSString*)userName {
  [chat appendTextAfterLinebreak:[NSString stringWithFormat:@"%@: %@", userName, message]];
  [chat scrollToBottom];
}


// Room closed from outside
- (void)roomTerminated:(id)room reason:(NSString*)reason {
  // Explain what happened
  UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Room terminated" message:reason delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
  [alert show];
    
    //exit
  [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark -
#pragma mark UITextFieldDelegate Method Implementations

// This is called whenever "Return" is touched on iPhone's keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
	if (theTextField == input) {
		// processs input
        
        ChattyAppDelegate *mainDelegate = [UIApplication sharedApplication].delegate;
    [chatRoom broadcastChatMessage:input.text fromUser:mainDelegate.name];

		// clear input
		[input setText:@""];
	}
	return YES;
}

@end
