//
//  ViewController.swift
//  GGChart_Swift
//
//  Created by zhaohw on 04/15/2020.
//  Copyright (c) 2020 zhaohw. All rights reserved.
//

import UIKit
import GGChart_Swift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let disyplayContents = ["lineChart", "pieChart"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        _ = CALayer.init()
        
        let chart = MinuteChart.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 200))
//        chart.backgroundColor = UIColor.green
        self.view.addSubview(chart)
        
//        let tableView = UITableView.init(frame: self.view.bounds, style: .grouped)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        self.view .addSubview(tableView);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        cell.textLabel?.text = self.disyplayContents[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.disyplayContents.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

