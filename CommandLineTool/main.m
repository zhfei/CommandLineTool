//
//  main.m
//  CommandLineTool
//
//  Created by 周飞 on 2020/1/6.
//  Copyright © 2020年 zhf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <mach-o/fat.h>
#import <mach-o/loader.h>


/*
 argc: 参数个数
 argv: 参数数组
 argv[0]: 当前可执行文件的路径
 */
int main(int argc, char * argv[]) {
    @autoreleasepool {
        if (argc == 1) {
            printf("-l 查看mach-o文件信息\n");
            return 0;
        }
        
        if (strcmp(argv[1], "-l") != 0) {
            printf("-l 查看mach-o文件信息\n");
            return 0;
        }
        
        //手机内没有被越狱app的Mach-O文件路径
        NSString *appPath = @"/var/containers/Bundle/Application/DBA6CFE6-7180-4638-A703-49387F0C0806/aisiweb.app/aisiweb";
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:appPath];
        
//        #define FAT_MAGIC    0xcafebabe    /* 小端表示 */
//        #define FAT_CIGAM    0xbebafeca    /* NXSwapLong(FAT_MAGIC) */
//
//        struct fat_header {
//            uint32_t    magic;        /* FAT_MAGIC or FAT_MAGIC_64 */
//            uint32_t    nfat_arch;    /* number of structs that follow */
//        };
        //Mach-O文件的开始前4个字节就是用于描述文件的类型
        //如：是否为胖二进制文件，arm64文件、armv7文件
        
        //读取Mach-O文件的前4个字节
        int lenght = sizeof(uint32_t);
        NSData *magicData = [fileHandle readDataOfLength:lenght];
        
        //magic data用于标示文件类型
        uint32_t magicNumber;
        //从magicData中读取4个字节填充到magicNumber中
        [magicData getBytes:&magicNumber length:lenght];
        
        if (magicNumber == FAT_MAGIC || magicNumber == FAT_CIGAM) {
            printf("Fat文件\n");
        } else if (magicNumber == MH_MAGIC || magicNumber == MH_MAGIC) {
            printf("非arm64文件\n");
        } else if (magicNumber == MH_MAGIC_64 || magicNumber == MH_MAGIC_64) {
            printf("arm64文件\n");
        } else {
            printf("类型判断失败----0x%x\n",magicNumber);
        }
        
        printf("magicNumber: 0x%x\n",magicNumber);
        
        //关闭文件读取句柄
        [fileHandle closeFile];
        return 0;
    }
}
