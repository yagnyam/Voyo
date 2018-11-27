//
//  VSNumberKeyboardAccessoryView.m
//  VIN Scan
//
//  Created by Ryan Worl on 6/12/14.
//  Copyright (c) 2014 Cellaflora. All rights reserved.
//

#import "VSNumberKeyboardAccessoryView.h"


@interface VSNumberKeyboardAccessoryView ()

@property (nonatomic, weak) id<UITextInput> textInput;

@end


@implementation VSNumberKeyboardAccessoryView

- (instancetype)initWithTextInput:(UIResponder<UITextInput> *)textInput
{
    UINib* nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:[NSBundle mainBundle]];
    NSArray* views = [nib instantiateWithOwner:nil options:nil];
    if (views.count) {
        self = views.firstObject;
    } else {
        return nil;
    }
    
    _textInput = textInput;
    
    return self;
}

#pragma mark - UIView

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(320.0f, 42.0f);
}

#pragma mark - Actions

- (IBAction)keyButtonTapped:(UIButton *)sender
{
    NSString* character = [sender titleForState:UIControlStateNormal];
    
    if ([self.textInput isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)self.textInput;
        
        UITextRange *selRange = textField.selectedTextRange;
        UITextPosition *selStartPos = selRange.start;
        UITextPosition *selEndPos = selRange.end;
        NSInteger idx = [textField offsetFromPosition:textField.beginningOfDocument toPosition:selStartPos];
        NSInteger length = [textField offsetFromPosition:selStartPos toPosition:selEndPos];
        
        if ([textField.delegate textField:textField shouldChangeCharactersInRange:NSMakeRange(idx, length) replacementString:character]) {
            [self.textInput insertText:character];
        }
    }
    else {
        [self.textInput insertText:character];
    }
}

@end
