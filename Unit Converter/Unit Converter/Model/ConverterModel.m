//
//  ConverterModel.m
//  Unit Converter
//
//  Created by Rahul Kumar Thai Valappil on 25/05/2016.
//  Copyright © 2016 Rahul Kumar Thai Valappil. All rights reserved.
//

#import "ConverterModel.h"

@implementation ConverterModel

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        self.convertionTypesArray = @[@"Area",@"Length",@"Temperature",@"Speed"];
        self.convertionUnitsDictionary = @{@"Area":@[@"Square kilometre",@"Square meter",@"Square foot"],
                                 @"Length":@[@"Meter",@"Kilometer",@"Mile",@"Foot"],
                                 @"Temperature":@[@"Celsius",@"Fahrenheit",@"Kelvin"],
                                 @"Speed":@[@"Kilometers per hour",@"Miles per hour",@"Meters per second"]};
        self.selectedConverterType = ConverterTypeArea;
    }
    return self;
}

-(NSString *)convertTheValue:(NSString *)inputString fromUnit:(NSString *)fromUnit toUnit:(NSString *)toUnit ofConverterType:(ConverterType)converterType{
    NSString *resultSring=@"";
    switch (converterType) {
        case ConverterTypeArea:
            resultSring = [self converAreaType:inputString fromUnit:fromUnit toUnit:toUnit];
            break;
            
        case ConverterTypeLength:
            resultSring = [self converLengthType:inputString fromUnit:fromUnit toUnit:toUnit];
            break;
            
        case ConverterTypeTemperature:
            resultSring = [self converTemperatureType:inputString fromUnit:fromUnit toUnit:toUnit];
            break;
            
        case ConverterTypeSpeed:
            resultSring = [self converSpeedType:inputString fromUnit:fromUnit toUnit:toUnit];
            break;
            
        default:

            break;
    }
    return resultSring;
}

-(NSString *)converAreaType:(NSString *)inputString fromUnit:(NSString *)fromUnit toUnit:(NSString *)toUnit{
    double result=0;
    if ([fromUnit isEqualToString:@"Square kilometre"]) {
        if([toUnit isEqualToString:@"Square meter"]){
            result = inputString.doubleValue*1000000;
        }
        else if([toUnit isEqualToString:@"Square foot"]){
            result = inputString.doubleValue*10764000;
        }
    }
    else if ([fromUnit isEqualToString:@"Square meter"]) {
        if([toUnit isEqualToString:@"Square kilometre"]){
            result = inputString.doubleValue/1000000;
        }
        else if([toUnit isEqualToString:@"Square foot"]){
            result = inputString.doubleValue*10.7639;
        }
    }
    else if ([fromUnit isEqualToString:@"Square foot"]) {
        if([toUnit isEqualToString:@"Square kilometre"]){
            result = inputString.doubleValue/10764000;
        }
        else if([toUnit isEqualToString:@"Square meter"]){
            result = inputString.doubleValue/10.7639;
        }
    }
    return [NSString stringWithFormat:@"%lf",result];
}

-(NSString *)converLengthType:(NSString *)inputString fromUnit:(NSString *)fromUnit toUnit:(NSString *)toUnit{
    double result=0;
    if ([fromUnit isEqualToString:@"Meter"]) {
        if([toUnit isEqualToString:@"Kilometer"]){
            result = inputString.doubleValue/1000;
        }
        else if([toUnit isEqualToString:@"Mile"]){
            result = inputString.doubleValue/1609.34;
        }
        else if([toUnit isEqualToString:@"Foot"]){
            result = inputString.doubleValue*3.28084;
        }
    }
    else if ([fromUnit isEqualToString:@"Kilometer"]) {
        if([toUnit isEqualToString:@"Meter"]){
            result = inputString.doubleValue*1000;
        }
        else if([toUnit isEqualToString:@"Mile"]){
            result = inputString.doubleValue/1.60934;
        }
        else if([toUnit isEqualToString:@"Foot"]){
            result = inputString.doubleValue*3280.84;
        }
    }
    else if ([fromUnit isEqualToString:@"Mile"]) {
        if([toUnit isEqualToString:@"Meter"]){
            result = inputString.doubleValue*1609.34;
        }
        else if([toUnit isEqualToString:@"Kilometer"]){
            result = inputString.doubleValue*1.60934;
        }
        else if([toUnit isEqualToString:@"Foot"]){
            result = inputString.doubleValue*5280;
        }
    }
    else if ([fromUnit isEqualToString:@"Foot"]) {
        if([toUnit isEqualToString:@"Meter"]){
            result = inputString.doubleValue/3.28084;
        }
        else if([toUnit isEqualToString:@"Kilometer"]){
            result = inputString.doubleValue/3280.84;
        }
        else if([toUnit isEqualToString:@"Mile"]){
            result = inputString.doubleValue/5280;
        }
    }
    return [NSString stringWithFormat:@"%lf",result];
}

-(NSString *)converTemperatureType:(NSString *)inputString fromUnit:(NSString *)fromUnit toUnit:(NSString *)toUnit{
    double result=0;
    if ([fromUnit isEqualToString:@"Celsius"]) {
        if([toUnit isEqualToString:@"Fahrenheit"]){
            result = inputString.doubleValue* 1.8 + 32;
        }
        else if([toUnit isEqualToString:@"Kelvin"]){
            result = inputString.doubleValue + 273.15;
        }
    }
    else if ([fromUnit isEqualToString:@"Fahrenheit"]) {
        if([toUnit isEqualToString:@"Celsius"]){
            result = (inputString.doubleValue - 32)/1.8;
        }
        else if([toUnit isEqualToString:@"Kelvin"]){
            result = (inputString.doubleValue+459.67)*5/9;
        }
    }
    else if ([fromUnit isEqualToString:@"Kelvin"]) {
        if([toUnit isEqualToString:@"Celsius"]){
            result = inputString.doubleValue-273.15;
        }
        else if([toUnit isEqualToString:@"Fahrenheit"]){
            result = inputString.doubleValue*9/5-459.67;
        }
    }
    return [NSString stringWithFormat:@"%.3lf",result];
}

-(NSString *)converSpeedType:(NSString *)inputString fromUnit:(NSString *)fromUnit toUnit:(NSString *)toUnit{
    double result=0;
    if ([fromUnit isEqualToString:@"Kilometers per hour"]) {
        if([toUnit isEqualToString:@"Miles per hour"]){
            result = inputString.doubleValue/1.60934;
        }
        else if([toUnit isEqualToString:@"Meters per second"]){
            result = inputString.doubleValue/3.6;
        }
    }
    else if ([fromUnit isEqualToString:@"Miles per hour"]) {
        if([toUnit isEqualToString:@"Kilometers per hour"]){
            result = inputString.doubleValue*1.60934;
        }
        else if([toUnit isEqualToString:@"Meters per second"]){
            result = inputString.doubleValue/2.23694;
        }
    }
    else if ([fromUnit isEqualToString:@"Meters per second"]) {
        if([toUnit isEqualToString:@"Kilometers per hour"]){
            result = inputString.doubleValue*3.6;
        }
        else if([toUnit isEqualToString:@"Miles per hour"]){
            result = inputString.doubleValue*2.23694;
        }
    }
    return [NSString stringWithFormat:@"%lf",result];
}

- (BOOL)isNumeric:(NSString *)inputString{
    NSScanner *scanner = [NSScanner scannerWithString:inputString];
    BOOL isNumeric = [scanner scanDouble:NULL] && [scanner isAtEnd];
    return isNumeric;
}

@end
