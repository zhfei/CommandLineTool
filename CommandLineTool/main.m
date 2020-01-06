//
//  main.m
//  CommandLineTool
//
//  Created by 周飞 on 2020/1/6.
//  Copyright © 2020年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSString *appPath = @"";
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:appPath];
        
        NSLog(@"hello...............\n");
        
        [fileHandle closeFile];
        return 0;
    }
}
