//
//  ViewController.swift
//  SwiftDemo
//
//  Created by tanjian on 2021/7/5.
//

import UIKit
import LZBluetooth

class ViewController: UITableViewController {
    var list = ["搜索设备"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
        LZBluetooth.initWithAppId("com.leshiguang.saas.rbac.demo.appid")
        
        LZBluetooth.getDeviceManager(withDeviceTypes: [
            NSNumber(value: LZDeviceType.typeBracelet.rawValue),
            NSNumber(value: LZDeviceType.typeScale.rawValue),
            NSNumber(value: LZDeviceType.typeBloodPressure.rawValue)
        ])
        
        LZLogger.shareInstance().loggerHandler = { (level, msg) in
            print("[\(level)] \(msg)")
        }
        
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        cell.textLabel?.text = list[indexPath.row];
        return cell;
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("indexPath \(indexPath.row)")
            let vc = DeviceListTableViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("没有处理的 \(indexPath.row)")
        }
    }
}

