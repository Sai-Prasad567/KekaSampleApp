//
//  ViewController.swift
//  KekaHRApp
//
//  Created by Sai Prasad on 07/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .insetGrouped)
        tableView.layer.cornerRadius = 6
        tableView.backgroundColor = .clear
        tableView.layer.borderColor = UIColor(red: 17 / 255.0, green: 81 / 255.0, blue: 231 / 255.0, alpha: 1.0).cgColor
        tableView.estimatedRowHeight = 22
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let viewModel = KekaViewModel()
    var selectedItems : [Int:String] = [:]
    var selectedIndex: [Int:Bool] = [:]
    
    let submitButton = UIButton()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Keka Sample App"
        self.viewModel.delegate = self
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(submitButton)
        self.view.addSubview(tableView)
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .lightGray
        submitButton.titleLabel?.textColor = .black
        submitButton.addTarget(self, action: #selector(printDetails), for: .touchUpInside)
        submitButton.isHidden = true
        submitButton.addConstraint(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 120, left: 20, bottom: 0, right: 0),size: CGSize(width: 100, height: 50))
        tableView.addConstraint(top: self.submitButton.bottomAnchor, leading:  self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 10, bottom: 50, right: 10))
        tableView.register(KekaAPITableViewCell.self, forCellReuseIdentifier: "dictCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadInformation() { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func printDetails() {
        if !selectedItems.isEmpty {
            for (key,items) in self.selectedItems {
                print(items)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, APIDelegates {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.information.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: KekaAPITableViewCell = KekaAPITableViewCell(style: .default, reuseIdentifier: "dictCell")
        cell.layer.borderWidth = 0.5
        if viewModel.information.count > 0 {
            let details = viewModel.information[indexPath.section]
            cell.configure(details)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = .red
        if let isSelected = selectedIndex[indexPath.section] {
            selectedIndex.removeValue(forKey: indexPath.section)
            cell?.backgroundColor = .clear
            selectedItems.removeValue(forKey: indexPath.section)
        }
        else {
            selectedIndex[indexPath.section] = true
            selectedItems[indexPath.section] = viewModel.information[indexPath.section].headline.main
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func getAPIResponse() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.submitButton.isHidden = false
        }
    }
}
