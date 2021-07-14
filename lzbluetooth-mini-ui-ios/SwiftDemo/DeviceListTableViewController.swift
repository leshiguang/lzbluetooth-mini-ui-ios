//
//  DeviceListTableViewController.swift
//  SwiftDemo
//
//  Created by tanjian on 2021/7/5.
//

import UIKit
import LZBluetooth

class DeviceListTableViewController: UITableViewController, LZDeviceDelegate {

    var deviceList: [LZBaseDevice] = [];
    let deviceManager = LZBluetooth.getDeviceManager(withDeviceTypes: [
        NSNumber(value: LZDeviceType.typeBracelet.rawValue),
        NSNumber(value: LZDeviceType.typeScale.rawValue),
        NSNumber(value: LZDeviceType.typeBloodPressure.rawValue)
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
        deviceManager.delegate = self;
        deviceManager.searchDevice(withDeviceTypes: nil) { [weak self] (resultDevice) in
            if (self?.deviceList.last(where: { (device) -> Bool in
                return resultDevice.mac == device.mac;
            }) != nil) {

            } else {
                self?.deviceList.append(resultDevice);
            }
            
//            self?.deviceManager.bind(withDevice: resultDevice, bindDelegate: self!);

            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deviceList.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let device = deviceList[indexPath.row];
        cell.textLabel?.text = "\(device.name!) \(device.mac!) \(device.rssi ?? 0)";
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = deviceList[indexPath.row];
        deviceManager.bind(withDevice: device, bindDelegate: self);
    }
    
    func device(_ device: LZDeviceProtocol, bindStateChanged bindState: LZBindState) {
        print("绑定回调 \(device.mac), \(bindState.rawValue)");
        switch bindState {
        case .authorizeFailure: break
            
        case .failure: break
            
        case .inputRandomNumber: break
            
        case .inputRandomNumberError: break
            
        case .inputUserNumberAndBindResult: break;
            
            
        default:
            assert(false, "设备状态未处理 \(bindState)");
        }
    }
}


extension DeviceListTableViewController: LZDeviceBindDelegate {
    
    
    
}
