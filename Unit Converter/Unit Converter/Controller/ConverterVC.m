//
//  ConverterVC.m
//  Unit Converter
//
//  Created by Rahul Kumar Thai Valappil on 25/05/2016.
//  Copyright © 2016 Rahul Kumar Thai Valappil. All rights reserved.
//

#import "ConverterVC.h"
#import "ConverterModel.h"

@interface ConverterVC ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPickerView *convertionTypePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *convertionUnitsPickerView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (strong,nonatomic) ConverterModel *converterModel;
@property (nonatomic) ConverterType converterType;
@property (nonatomic) NSString *selectedConverTypeString;
@property (nonatomic) NSString *unitConvertedFrom;
@property (nonatomic) NSString *unitConvertedTo;

- (IBAction)inputTextFieldEditingChanged:(id)sender;

@end

@implementation ConverterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.converterModel = [[ConverterModel alloc]init];
    self.converterType = ConverterTypeArea;
    self.selectedConverTypeString = @"Area";
    self.unitConvertedFrom = self.converterModel.convertionUnitsDictionary[@"Area"][0];
    self.unitConvertedTo = self.converterModel.convertionUnitsDictionary[@"Area"][0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    // If you are using Xcode 6 or iOS 7.0, you may need this line of code. There was a bug when you
    // rotated the device to landscape. It reported the keyboard as the wrong size as if it was still in portrait mode.
    //kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.resultLabel.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.resultLabel.frame animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (pickerView == self.convertionTypePickerView) {
        return 1;
    }
    else{
        return 2;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.convertionTypePickerView) {
        return self.converterModel.convertionTypesArray.count;
    }
    else{
        return [self.converterModel.convertionUnitsDictionary[self.selectedConverTypeString] count];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    NSString *title=@"";
    if (pickerView == self.convertionTypePickerView) {
        title = self.converterModel.convertionTypesArray[row];
    }
    else{
        title = self.converterModel.convertionUnitsDictionary[self.selectedConverTypeString][row];
    }
    
    UILabel *titleLabel = (UILabel*)view;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    
    titleLabel.font = [UIFont systemFontOfSize:17.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    
    return titleLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.convertionTypePickerView) {
        self.converterType = row;
        self.selectedConverTypeString = self.converterModel.convertionTypesArray[row];
        [self.convertionUnitsPickerView reloadAllComponents];
    }

    NSInteger leftRow = [self.convertionUnitsPickerView selectedRowInComponent:0];
    NSInteger righttRow = [self.convertionUnitsPickerView selectedRowInComponent:1];
    self.unitConvertedFrom = self.converterModel.convertionUnitsDictionary[self.selectedConverTypeString][leftRow];
    self.unitConvertedTo = self.converterModel.convertionUnitsDictionary[self.selectedConverTypeString][righttRow];
    
    [self convertTheValue:self.inputTextField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)inputTextFieldEditingChanged:(id)sender {
    UITextField *inputTextField = (UITextField *)sender;
    NSString *inputString = inputTextField.text;
    [self convertTheValue:inputString];
}

-(void)convertTheValue:(NSString *)inputString{
    if(inputString.length==0){
        self.resultLabel.text = @"";
        self.resultLabel.highlighted = NO;
    }
    else if ([self.converterModel isNumeric:inputString]) {
        if([self.unitConvertedFrom isEqualToString:self.unitConvertedTo]){
            self.resultLabel.text = inputString;
        }
        else{
            self.resultLabel.text = [self.converterModel convertTheValue:inputString fromUnit:self.unitConvertedFrom toUnit:self.unitConvertedTo ofConverterType:self.converterType];
        }
        self.resultLabel.highlighted = NO;
    }
    else{
        self.resultLabel.highlighted = YES;
        self.resultLabel.text = @"Incorrect unit";
    }
}
@end
