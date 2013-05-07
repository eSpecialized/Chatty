//
//  WelcomeViewController.m
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

#import "WelcomeViewController.h"
#import "ChattyAppDelegate.h"
#import "ChattyViewController.h"


@implementation WelcomeViewController


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        //init
        self.title = @"Welcome";
    }
    
    return self;
}

// App delegate will call this whenever this view becomes active
- (void)activate {
  // Display keyboard
  [input becomeFirstResponder];
}


// This is called whenever "Return" is touched on iPhone's keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
  if ( theTextField.text == nil || [theTextField.text length] < 1 ) {
    return NO;
  }

  // Save user's name
    ChattyAppDelegate *mainDelegate = [UIApplication sharedApplication].delegate;
    [mainDelegate setName:theTextField.text];

  // Dismiss keyboard
  [theTextField resignFirstResponder];

  // Move on to the next screen
    ChattyViewController *cvc = [[ChattyViewController alloc] initWithNibName:@"ChattyViewController" bundle:nil];
    
    [self.navigationController pushViewController:cvc animated:YES];

	return YES;
}

@end
