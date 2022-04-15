//
//  main.m
//  LinkMapConvertToTable
//
//  Created by 王贵彬(EX-WANGGUIBIN001) on 2022/4/7.
//

#import <Foundation/Foundation.h>

NSInteger getStrIndex(NSString *originStr){
    NSInteger index =  NSNotFound;
    if ([originStr containsString:@"K"]) {
       index = [originStr rangeOfString:@"K"].location;
        if (index > 6) {
            index = NSNotFound;
        }
    }

    if (index == NSNotFound) {
        if ([originStr containsString:@"M"]) {
           index = [originStr rangeOfString:@"M"].location;
            if (index > 6) {
                index = NSNotFound;
            }
        }
    }
    return index;
}

NSString * getNumber(NSString *str){
    return [str substringToIndex:str.length-1];
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSMutableString *formatStrM = [NSMutableString string];
        NSString *sourceStr = [[NSString alloc] initWithUTF8String:argv[1]];
        NSMutableArray<NSString*> * rowArr = [[sourceStr componentsSeparatedByString:@"\n"] mutableCopy];
        [rowArr removeObjectAtIndex:0];
        [rowArr removeObjectAtIndex:0];
        //标题
        [formatStrM appendString:@"\n|文件大小|文件名|\n"];
        [formatStrM appendString:@"| ---- | ---- |\n"];

        NSString *allSize = nil;
        float totalSize = 0.0f;
        
        for (NSString *row in rowArr) {
            NSInteger index = getStrIndex(row) + 1;
            if (index == NSNotFound) {
            }else{
                if ([row containsString:@"总大小"]) {
                    allSize = [row stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                }else if (row.length > index ) {
                    NSString *left = [[row substringToIndex:index] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if ([left containsString:@"M"]) {
                        totalSize += ([getNumber(left) floatValue] *1000);
                    }else{
                        totalSize += [getNumber(left) floatValue];
                    }
                    NSString *right = [[row substringFromIndex:index] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    NSLog(@"%@ - %@",left,right);
                    [formatStrM appendFormat:@"| %@ | %@ |\n",left,right];
                }
            }
         }
        [formatStrM appendString:@"\n"];
        [formatStrM appendFormat:@"**%@ (%.2fK)**",allSize,totalSize];
        NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Desktop/linkMap.md"];
        [[formatStrM dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
    }
    return 0;
}
