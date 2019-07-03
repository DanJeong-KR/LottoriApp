//
//  RandomViewController.swift
//  Lottori
//
//  Created by chang sic jung on 21/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit


class RandomViewController: UIViewController {
    
    private var titleImageView = UIImageView(image: UIImage(named: "title"))
    private var tableView: UITableView = {
        let tb = UITableView()
        tb.layer.cornerRadius = 10
        tb.rowHeight = 80
        tb.register(RankCell.self, forCellReuseIdentifier: "rankCell")
        return tb
    }()
    
    private var fixBallButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("고정볼 설정", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        bt.layer.cornerRadius = 20
        return bt
    }()
    
    private var randomBallButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("당첨볼 생성하기", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        bt.layer.cornerRadius = 30
        return bt
    }()
    
    private var tableDataArr:[RankDataModel] = []
    var showFixedNumArray = [0,0,0,0,0,0]
    
    let userFixedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView = titleImageView
        titleImageView.contentMode = .scaleAspectFit
        title = "랜덤볼"
        
        userFixedCollectionView.dataSource = self
        userFixedCollectionView.register(FixedBallCell.self, forCellWithReuseIdentifier: "selectedFix")
        
        configure()
        autolayouts()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userFixedCollectionView.reloadData()
        
    }
    
    
    var layoutState = true
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        userFixedCollectionView.reloadData()
        
        if layoutState {
            let cellWidth: CGFloat = (240 - (CollectionCellUI.toSpace * 5)) / 6
            let layout = userFixedCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = CollectionCellUI.toSpace
            layout.minimumInteritemSpacing = CollectionCellUI.toSpace
            userFixedCollectionView.contentInset = UIEdgeInsets(top: CollectionCellUI.space, left: CollectionCellUI.space, bottom: CollectionCellUI.space, right: CollectionCellUI.space)
        }
        layoutState = false
    }
    
    private func configure() {
        let buttonArr = [fixBallButton,randomBallButton]
        // add subview 했어?
        view.addSubviews(buttonArr)
        view.addSubviews([tableView])
        
        userFixedCollectionView.backgroundColor = .clear
        view.addSubview(userFixedCollectionView)
        
        // layout 설정 했어?
        buttonArr.forEach{
            $0.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            $0.setTitleColor(#colorLiteral(red: 0, green: 0.6769893765, blue: 0.330976665, alpha: 1), for: .normal)
            $0.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        }
        
        //delegate 설정 했어?
        tableView.dataSource = self
    }
    
    //MARK: - 오토레이아웃
    private func autolayouts() {
        // 고정볼
        fixBallButton.layout.top(constant: 10).leading(constant: 5)
        fixBallButton.layout.widthAnchor.constraint(equalTo: randomBallButton.widthAnchor, multiplier: 0.3).isActive = true
        
        // 랜덤볼
        randomBallButton.layout.top(equalTo: fixBallButton.bottomAnchor, constant: 10).leading(constant: 5).trailing(constant: -5)
        randomBallButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        // 테이블 뷰
        tableView.layout.top(equalTo: randomBallButton.bottomAnchor, constant: 15).leading(constant: 5).trailing(constant: -5).bottom()
        
        // 컬렉션 뷰
        userFixedCollectionView.layout.top().leading(equalTo: fixBallButton.trailingAnchor, constant: 5).trailing().bottom(equalTo: randomBallButton.topAnchor)
    }
    
    // MARK: - 버튼 액션 메소드
    @objc private func buttonAction(_ sender: UIButton) {
        
        switch sender.titleLabel?.text {
            
        case "고정볼 설정":
            // 고정볼 설정 눌렀을 때 액션
            let fixedVC = FixedBallViewController()
//            fixedVC.modalPresentationStyle = .overCurrentContext
            present(fixedVC, animated: true)

        case "당첨볼 생성하기":
            showFixedNumArray = Lottori.randomBallGenerator(paramArr: showFixedNumArray).map{ Int($0)!}
            userFixedCollectionView.reloadData()
            
            
            tableDataArr = Lottori.searchPastRanking(inputBallNums: showFixedNumArray.map{ String($0)})
            tableView.reloadData()
        default:
            break
        }
    }
}

extension RandomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell", for: indexPath) as! RankCell
        
        cell.model = tableDataArr[indexPath.row]
        
        
        
        return cell
    }
}

extension RandomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showFixedNumArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedFix", for: indexPath) as! FixedBallCell
        
        let ballTitle = String(showFixedNumArray[indexPath.row])
        cell.ball.backgroundColor = Lottori.setupBallColor(ballText: ballTitle)
        cell.ball.setTitle(String(ballTitle), for: .normal)
        //cell.ball.setTitleColor(.black, for: .normal)
        
        cell.ballTitleColor = .black
        return cell
    }
    
    
}
