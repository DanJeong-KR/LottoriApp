//
//  RankingViewController.swift
//  Lottori
//
//  Created by Solji Kim on 22/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {

    let headerView = UIView()
    let headerNumLabel = UILabel()
    let headerTextLabel = UILabel()
    let headerTextLabel2 = UILabel()
    let tableView = UITableView()
    let closeButton = UIButton()
    
    var dataArr: [RankDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RankCell.self, forCellReuseIdentifier: "rankCell")
        
        configure()
        setAutoLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func configure() {
        headerNumLabel.textColor = .white
        headerNumLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        headerNumLabel.frame = CGRect(x: 15, y: 10, width: 250, height: 30)
        headerView.addSubview(headerNumLabel)
    
        headerTextLabel.textColor = .white
        headerTextLabel.textAlignment = .center
        headerTextLabel.text = "지금 뽑은 번호의"
        headerTextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        headerTextLabel.frame = CGRect(x: 125, y: 40, width: 130, height: 40)
        headerView.addSubview(headerTextLabel)
        
        headerTextLabel2.textColor = .yellow
        headerTextLabel2.text = "과거순위"
        headerTextLabel2.textAlignment = .center
        headerTextLabel2.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        headerTextLabel2.frame = CGRect(x: 255, y: 35, width: 100, height: 40)
        headerView.addSubview(headerTextLabel2)
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
        headerView.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.8030554366)
        tableView.tableHeaderView = headerView
        
        tableView.rowHeight = 80
        view.addSubview(tableView)
        
        closeButton.setTitle("닫기", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.705854024)
        closeButton.addTarget(self, action: #selector(closeButtonDidTap(_:)), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    func setAutoLayout() {
        
        tableView.layout.top().leading().trailing().bottom(equalTo: closeButton.topAnchor)
        
        closeButton.layout.leading().trailing().bottom().heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func closeButtonDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension RankingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell", for: indexPath) as! RankCell
        
        cell.selectionStyle = .none
        
        for i in 0..<cell.compoundNumArray.count {
            if i == 6 {
                cell.compoundNumArray[i].text = "+"
                cell.compoundNumArray[i].textColor = .black
                cell.compoundNumArray[i].font = UIFont.boldSystemFont(ofSize: 24)
                cell.compoundNumArray[i].backgroundColor = .clear
            }
            
        }
        cell.model = dataArr[indexPath.row]
        return cell
    }
}

extension RankingViewController: UITableViewDelegate {
    
}
