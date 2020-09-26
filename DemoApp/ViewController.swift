//
//  ViewController.swift
//  DemoApp
//
//  Created by Guest User on 26/09/20.
//  Copyright © 2020 Guest User. All rights reserved.
//

import UIKit
//class TableViewCustomCell: UITableViewCell {
//
//}

class ViewController: UIViewController {
    
    // UI IBOutlets
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
    // Properties
    let testViewModel: TestViewModel = TestViewModel()
    var testData: TestList?
    var leftList: TestList = []
    var rightList: TestList = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    func bindData() {
        testViewModel.testDataObservable.bind { [weak self] (testList) in
            guard let self = self else {return}
            self.testData = testList
            self.updateDataSouce()
        }
    }
    
    func updateDataSouce() {
        let data = testViewModel.testData
        if data.count > 20 {
            rightList = Array(data[20..<data.count])
            leftList = Array(data[0..<20])
        } else {
            leftList = data;
        }
    }
    
    func reloadData(side: TestViewSide) {
        switch side {
        case .leftTableView:
            leftTableView.reloadData()
        case .rightTableView:
            rightTableView.reloadData()
        }
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftList.count
        }
        if tableView == rightTableView {
            return rightList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tView = leftTableView, tView == tableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "leftCell") as? TestView else {
                return UITableViewCell()
            }
            cell.title.text = leftList[indexPath.row].title
            cell.subtitle.text = leftList[indexPath.row].subtitle
            return cell
        }
        if let tView = rightTableView, tView == tableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "rightCell") as? TestView else {
                return UITableViewCell()
            }
            cell.title.text = rightList[indexPath.row].title
            cell.subtitle.text = rightList[indexPath.row].subtitle
            return cell
        }
        return UITableViewCell()
    }
}

