//
//  ViewController.m
//  Read.xlsFile
//
//  Created by Wang on 16/3/9.
//  Copyright © 2016年 WangJace. All rights reserved.
//

#import "ViewController.h"
#import "DHxlsReader.h"

extern int xls_debug;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"xls"];
    DHxlsReader *reader = [DHxlsReader xlsReaderWithPath:path];
    assert(reader);
    NSLog(@"row = %u, col = %u",[reader numberOfRowsInSheet:0],[reader numberOfColsInSheet:0]);
    [reader startIterator:0];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (int i = 1; i <= (int)[reader numberOfRowsInSheet:0]; i++) {
        DHcell *cellA = [reader cellInWorkSheetIndex:0 row:i colStr:"A"];
        DHcell *cellB = [reader cellInWorkSheetIndex:0 row:i colStr:"B"];
        DHcell *cellC = [reader cellInWorkSheetIndex:0 row:i colStr:"C"];
        [data addObject:@{
                          @"index":cellA.val,
                          @"value":cellB.val,
                          @"String":cellC.str == nil ? @"":cellC.str
                          }];
        
    }
    NSLog(@"%@",data);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
