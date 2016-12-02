//
//  ViewController.swift
//  AUSome Tracking
//
//  Created by Yan on 11/30/16.
//  Copyright © 2016 Yan. All rights reserved.
//

import UIKit

class ViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if !(self.isJSONFileExist()) {
            print("File does not exist. Create a JSON file.")
            Simulator().writeToFile()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func isJSONFileExist() -> Bool {
        let test = Simulator()
        let fileURL = test.dataFileURL()
        
        if (FileManager.default.fileExists(atPath: fileURL.path!)) {
            return true
        }
        return false
    }

}

