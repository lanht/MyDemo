//
//  ViewController.m
//  VinDemo
//
//  Created by cp316 on 17/3/3.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "ViewController.h"
#import "DHxlsReader.h"
#import "ValidationVIN.h"

extern int xls_debug;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"vin2" ofType:@"xls"];
    DHxlsReader *reader = [DHxlsReader xlsReaderWithPath:path];
    assert(reader);
    NSLog(@"row = %u, col = %u",[reader numberOfRowsInSheet:0],[reader numberOfColsInSheet:0]);
    [reader startIterator:0];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (int i = 1; i <= (int)[reader numberOfRowsInSheet:0]; i++) {
        DHcell *cellA = [reader cellInWorkSheetIndex:0 row:i colStr:"A"];
//        DHcell *cellB = [reader cellInWorkSheetIndex:0 row:i colStr:"B"];
//        DHcell *cellC = [reader cellInWorkSheetIndex:0 row:i colStr:"C"];
        [data addObject:@{
//                          @"index":cellA.val,
//                          @"value":cellB.val,
                          @"String":cellA.str == nil ? @"":cellA.str
                          }];
        
    }
//    [self checkVin:data];

}

- (void)checkVin:(NSMutableArray *)data {
    for (int i = 0; i < data.count; i++) {
        NSDictionary *dic = data[i];
        NSString *vin = dic[@"String"];
        BOOL isVin = [ValidationVIN validatVinWithCode:vin];
        if (!isVin) {
            NSLog(@"错误vin码 ＝ %@",vin);
        }
        if (i == data.count - 1) {
            NSLog(@"检查完毕");
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
