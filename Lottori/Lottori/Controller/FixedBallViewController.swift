//
//  FixedBallViewController.swift
//  Lottori
//
//  Created by Solji Kim on 23/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

private struct Standard {
    static let space: CGFloat = 0
    static let size: CGFloat = 330
    static let toSpace: CGFloat = 5
}

class FixedBallViewController: UIViewController {
    
    let fixedBallView = UIView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let collectionlabel = UILabel()
    let completeButton = UIButton()
    let alertLable = UILabel()
    
    var ballNumbers = Array(1...45)
    var fixedNumArray = [Int]()
    
    var isSelected: [Bool] = {
        var temp: [Bool] = []
        for _ in 0..<45 {
            temp.append(false)
        }
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        collectionView.dataSource = self
        collectionView.register(FixedBallCell.self, forCellWithReuseIdentifier: "fixedBall")
        
        configure()
        setAutoLayout()
        
    }
    
    var layoutState = true
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if layoutState {
            let cellWidth: CGFloat = (Standard.size - (Standard.toSpace * 6)) / 7
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            layout.minimumLineSpacing = Standard.toSpace
            layout.minimumInteritemSpacing = Standard.toSpace
            collectionView.contentInset = UIEdgeInsets(top: Standard.space, left: Standard.space, bottom: Standard.space, right: Standard.space)
        }
        layoutState = false
        
        fixedBallView.layer.cornerRadius = 30
        fixedBallView.clipsToBounds = true
    }
    
    
    func configure() {
        
        fixedBallView.backgroundColor = .white
        view.addSubview(fixedBallView)
        
        collectionlabel.backgroundColor = #colorLiteral(red: 0, green: 0.7043418516, blue: 0.7177799205, alpha: 1)
        collectionlabel.text = "고정수 선택"
        collectionlabel.textColor = .white
        collectionlabel.textAlignment = .center
        fixedBallView.addSubview(collectionlabel)
        
        completeButton.backgroundColor = #colorLiteral(red: 0, green: 0.7043418516, blue: 0.7177799205, alpha: 1)
        completeButton.setTitle("완료", for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.titleLabel?.textAlignment = .center
        completeButton.addTarget(self, action: #selector(completeBtnDidTap(_:)), for: .touchUpInside)
        fixedBallView.addSubview(completeButton)
        
        collectionView.backgroundColor = .clear
        fixedBallView.addSubview(collectionView)
        
        alertLable.backgroundColor = #colorLiteral(red: 0.1527204949, green: 0.1527204949, blue: 0.1527204949, alpha: 1)
        alertLable.alpha = 0
        alertLable.textColor = .white
        alertLable.textAlignment = .center
        alertLable.layer.cornerRadius = 20
        alertLable.layer.masksToBounds = true
        view.addSubview(alertLable)
    }
    
    func setAutoLayout() {
        fixedBallView.layout
            .top(constant: 50)
            .leading(constant: 20)
            .trailing(constant: -20)
            .bottom(constant: -150)
        
        collectionlabel.layout
            .top(equalTo: fixedBallView.topAnchor)
            .leading(equalTo: fixedBallView.leadingAnchor)
            .trailing(equalTo: fixedBallView.trailingAnchor)
            .heightAnchor.constraint(equalToConstant: 40).isActive = true

        collectionView.layout
            .top(equalTo: collectionlabel.bottomAnchor)
            .leading(equalTo: fixedBallView.leadingAnchor)
            .trailing(equalTo: fixedBallView.trailingAnchor)
            .bottom(equalTo: completeButton.topAnchor)
        
        completeButton.layout
            .leading(equalTo: fixedBallView.leadingAnchor)
            .bottom(equalTo: fixedBallView.bottomAnchor)
            .trailing(equalTo: fixedBallView.trailingAnchor)
            .heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        alertLable.layout
            .centerX()
            .bottom(constant: -30)
            .heightAnchor.constraint(equalToConstant: 50).isActive = true
        alertLable.widthAnchor.constraint(equalToConstant: 230).isActive = true
    }
    
    // 고정수와 나머지 수를 구별하기 위해 Random 으로 데이터 전달하기 전 처리
    func findFixball(fixedNumArr: [Int]) -> [Int] {
        if fixedNumArr.isEmpty {
            return [0, 0, 0, 0, 0, 0]
        } else if fixedNumArr.count == 1 {
            return fixedNumArr + [0,0,0,0,0]
        } else if fixedNumArr.count == 2 {
            return fixedNumArr + [0,0,0,0]
        } else if fixedNumArr.count == 3 {
            return fixedNumArr + [0,0,0]
        } else if fixedNumArr.count == 4 {
            return fixedNumArr + [0,0]
        } else if fixedNumArr.count == 5 {
            return fixedNumArr + [0]
        } else {
            return [0,0,0,0,0,0]
        }
    }
    
    @objc func completeBtnDidTap(_ sender: UIButton) {
        
        if let naviVC = presentingViewController as? UINavigationController {
            if let randomVC = naviVC.viewControllers.last as? RandomViewController {
                
                
                randomVC.showFixedNumArray = findFixball(fixedNumArr: self.fixedNumArray)
                dismiss(animated: true)
            }
        }
        
    }
}

extension FixedBallViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ballNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fixedBall", for: indexPath) as! FixedBallCell
        
        cell.delegate = self
        
        cell.ball.backgroundColor = #colorLiteral(red: 0.7792800315, green: 0.7948656321, blue: 0.7948656321, alpha: 1)
        cell.ball.setTitleColor(.white, for: .normal)
        cell.ball.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        cell.ball.layer.borderWidth = 1
        cell.ball.layer.borderColor = UIColor.white.cgColor
        cell.ball.setTitle(String(ballNumbers[indexPath.row]), for: .normal)
        
        return cell
    }
}

extension FixedBallViewController: FixedBallDelegate {
    
    func actionBall(cell: FixedBallCell) {
        
        let indexPath = collectionView.indexPath(for: cell)
        let index = fixedNumArray.firstIndex(of: Int(cell.ball.currentTitle!)!)
        
        guard !fixedNumArray.contains(Int(cell.ball.currentTitle!)!) else {
            fixedNumArray.remove(at: index!)
            cell.ball.backgroundColor = #colorLiteral(red: 0.7792800315, green: 0.7948656321, blue: 0.7948656321, alpha: 1)
            cell.ball.setTitleColor(.white, for: .normal)
            cell.ball.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            cell.ball.layer.borderWidth = 1
            cell.ball.layer.borderColor = UIColor.white.cgColor
            return
        }
        
        guard fixedNumArray.count < 5 else {

            self.alertLable.alpha = 1
            alertLable.text = "고정수는 5개까지만 가능합니다."
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 2) {
                    self.alertLable.alpha = 0
                }
            }
            
            
            return
        }

        isSelected[(indexPath?.row)!].toggle()

        if isSelected[(indexPath?.row)!] {
            cell.ball.backgroundColor = #colorLiteral(red: 0, green: 0.5864300502, blue: 1, alpha: 1)
            cell.ball.setTitleColor(.black, for: .normal)
            cell.ball.layer.borderWidth = 2.5
        } else {
            cell.ball.backgroundColor = #colorLiteral(red: 0.7792800315, green: 0.7948656321, blue: 0.7948656321, alpha: 1)
            cell.ball.setTitleColor(.white, for: .normal)
            cell.ball.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            cell.ball.layer.borderWidth = 1
            cell.ball.layer.borderColor = UIColor.white.cgColor
        }

        guard !fixedNumArray.contains(Int(cell.ball.currentTitle!)!) else {
            fixedNumArray.remove(at: index!)
            return
        }

        fixedNumArray.append(Int(cell.ball.currentTitle!)!) // title arr
        fixedNumArray.sort()
        
    }
}
