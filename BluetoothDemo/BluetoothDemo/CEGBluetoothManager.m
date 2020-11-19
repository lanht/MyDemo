//
//  CEGBluetoothManager.m
//  CheeGu
//
//  Created by Lanht on 2020/11/16.
//  Copyright © 2020 gzfns. All rights reserved.
//

#import "CEGBluetoothManager.h"
#import "Peripheral.h"

@interface CEGBluetoothManager ()<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *bluetoothCentral;
@property (nonatomic, copy) void(^poweredCallBack)(void);
@property (nonatomic, strong) NSMutableArray *peripherals;
@property (nonatomic, strong) NSMutableArray<Peripheral *> *outPeripherals;


@end

@implementation CEGBluetoothManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static CEGBluetoothManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[CEGBluetoothManager alloc]init];
        [manager initBluetoothCentral];
    });
    return manager;
}

- (NSMutableArray *)peripherals {
    if (!_peripherals) {
        _peripherals = [NSMutableArray array];
    
    }
    return _peripherals;
}

- (NSMutableArray<Peripheral *> *)outPeripherals {
    if (!_outPeripherals) {
           _outPeripherals = [NSMutableArray array];
       
       }
       return _outPeripherals;
}

- (void)initBluetoothCentral {
    dispatch_queue_t queue = dispatch_queue_create("com.cheegu.bluetooth", DISPATCH_QUEUE_SERIAL);
    
    NSDictionary *dict = @{CBCentralManagerOptionShowPowerAlertKey : @YES, CBCentralManagerOptionRestoreIdentifierKey : @"com.cheegu.bluetooth"};
    _bluetoothCentral = [[CBCentralManager alloc]initWithDelegate:self queue:queue options:nil];
}

- (void)beginScan {
    if (self.bluetoothCentral.state == CBCentralManagerStatePoweredOn) {
        NSDictionary *option = @{CBCentralManagerScanOptionAllowDuplicatesKey : [NSNumber numberWithBool:NO], CBCentralManagerOptionShowPowerAlertKey : @YES};
        [self.bluetoothCentral scanForPeripheralsWithServices:nil options:option];

    } else {
        __weak typeof (self) weakSelf = self;
        self.poweredCallBack = ^{
            NSDictionary *option = @{CBCentralManagerScanOptionAllowDuplicatesKey : [NSNumber numberWithBool:NO], CBCentralManagerOptionShowPowerAlertKey : @YES};
            [weakSelf.bluetoothCentral scanForPeripheralsWithServices:nil options:option];
        };
    }
}

- (void)stopScan {
    [self.bluetoothCentral stopScan];
}

  //对广播包中的数据进行格式转换
- (NSString *)transformStringWithData:(NSData *)data{
     NSString *result;
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    if (!dataBuffer) {
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for (int i = 0; i < dataLength; i++) {
        //02x 表示两个位置 显示的16进制
        [hexString appendString:[NSString stringWithFormat:@"%02lx",(unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    
    return result;
}

- (void)connectWithId:(NSString *)identifier {
    CBPeripheral *p = [self getPeripheralWithIdentifier:identifier];
    if (p) {
        if (p.state == CBPeripheralStateConnected || p.state == CBPeripheralStateConnecting) {
            [self.bluetoothCentral cancelPeripheralConnection:p];
        }
        
        [self.bluetoothCentral connectPeripheral:p options:nil];
        p.delegate = self;
    }
}

- (CBPeripheral *)getPeripheralWithIdentifier:(NSString *)identifier {
    CBPeripheral * peripheral = nil;
    for (CBPeripheral *p in self.peripherals) {
        if ([p.identifier.UUIDString isEqualToString:identifier]) {
            peripheral = p;
        }
    }
    return peripheral;
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStateUnknown:
                NSLog(@"central.state -- CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
                NSLog(@"central.state -- CBCentralManagerStateResetting");

            break;
        case CBCentralManagerStateUnsupported:
                NSLog(@"central.state -- CBCentralManagerStateUnsupported");

            break;
        case CBCentralManagerStateUnauthorized:
                NSLog(@"central.state -- CBCentralManagerStateUnauthorized");

            break;
        case CBCentralManagerStatePoweredOff:
                NSLog(@"central.state -- CBCentralManagerStatePoweredOff");

            break;
        case CBCentralManagerStatePoweredOn: {
            NSLog(@"central.state -- CBCentralManagerStatePoweredOn");
            NSArray *services = @[[CBUUID UUIDWithString:@"EB9EF785-DA5E-880F-C59B-7AEB9FA170B0"]];
//            [self.bluetoothCentral scanForPeripheralsWithServices:services options:nil];
            [self.bluetoothCentral scanForPeripheralsWithServices:nil options:nil];

        }

            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
     NSLog(@"find peripheral --- %@ \n %@", peripheral, advertisementData);
    
    if (![self.peripherals containsObject:peripheral]) {
        [self.peripherals addObject:peripheral];
        
        NSString *name = peripheral.name ?: @"Unnamed";

        Peripheral *p = [[Peripheral alloc]init];
        p.name = name;
        p.uuid = peripheral.identifier.UUIDString;
        [self.outPeripherals addObject:p];
        
        NSMutableArray *peripheralNames = [NSMutableArray array];
        for (CBPeripheral *peripheral in self.peripherals) {

            [peripheralNames addObject:name];
        }
                
        if ([self.delegate respondsToSelector:@selector(bluetoothManager:didUpdatePeripherals:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate bluetoothManager:self didUpdatePeripherals:[self.outPeripherals copy]];

            });
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"%@ --- 链接成功", peripheral.name);
    [self.bluetoothCentral stopScan];
    
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"%@ --- 链接失败", peripheral.name);
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"%@ --- 断开链接", peripheral.name);
}

#pragma mark - CBPeripheralDelegate
- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral {
    NSLog(@"peripheralDidUpdateName -- %@",peripheral.name);
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    if (peripheral.services.count > 0) {
        for (CBService *service in peripheral.services) {
            NSLog(@"didDiscoverServices -- %@",service);
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error {
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"扫描到服务：%@ 的特征：%@ \n %@", service.UUID, characteristic.UUID, characteristic);
        
        [peripheral readValueForCharacteristic:characteristic];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"读取到特征 -- %@",characteristic.UUID.UUIDString);
    
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
}

@end
