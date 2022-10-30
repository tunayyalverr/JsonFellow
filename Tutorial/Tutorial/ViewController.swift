//
//  ViewController.swift
//  Tutorial
//
//  Created by Alver, Tunay on 30.10.2022.
//

import UIKit
import JsonFellow

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }

    func test() {
        let users = JsonFellow.make([User].self, "mockData")
        print(users)
    }
}

