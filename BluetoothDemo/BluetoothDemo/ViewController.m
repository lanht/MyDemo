//
//  ViewController.m
//  BluetoothDemo
//
//  Created by Lanht on 2020/11/16.
//  Copyright © 2020 gzfns. All rights reserved.
//

#import "ViewController.h"
#import "CEGBluetoothManager.h"
#import "Peripheral.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, CEGBluetoothManagerDeletate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *peripherals;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CEGBluetoothManager *manager = [CEGBluetoothManager shareInstance];
    manager.delegate = self;
}

- (IBAction)beginScan:(id)sender {
    [[CEGBluetoothManager shareInstance] beginScan];
}

- (IBAction)stopScan:(id)sender {
    [[CEGBluetoothManager shareInstance] stopScan];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    Peripheral *p = self.peripherals[indexPath.row];
    cell.textLabel.text = p.name;
    cell.detailTextLabel.text = p.uuid;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Peripheral *p = self.peripherals[indexPath.row];
    [[CEGBluetoothManager shareInstance] connectWithId:p.uuid];
}

#pragma mark -
- (void)bluetoothManager:(CEGBluetoothManager *)manager didUpdatePeripherals:(NSArray *)peripherals {
    self.peripherals = peripherals;
    [self.tableView reloadData];
}

@end
