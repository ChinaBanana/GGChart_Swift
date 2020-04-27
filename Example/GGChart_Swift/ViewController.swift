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
        
        let chart = KLineChart.init(frame: CGRect.init(x: 0, y: 100, width: view.frame.width, height: 300))
//        chart.backgroundColor = UIColor.green
        view.addSubview(chart)
        
        let kLineScale = KLineScaler.init()
        kLineScale.shapeWidth = 10
        kLineScale.shapeInterval = 3
        
        let bundle = Bundle.main.path(forResource: "600887_kdata", ofType: "json")
        if let path = bundle {
            let data = NSData.init(contentsOfFile: path)!
             
            let decoder = JSONDecoder()
            if let models = try? decoder.decode(Array<KLineData>.self, from: data as Data) {
                chart.updateContentsWith(models)
            }
        }
        
       
        
//        let tableView = UITableView.init(frame: view.bounds, style: .grouped)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        view .addSubview(tableView);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        cell.textLabel?.text = disyplayContents[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disyplayContents.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

