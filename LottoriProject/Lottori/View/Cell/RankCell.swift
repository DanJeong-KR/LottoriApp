//
//  RankCell.swift
//  Lottori
//
//  Created by Solji Kim on 22/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class RankCell: UITableViewCell {
    
    let thLabel = UILabel()
    let compoundNumView = UIView()
    let rankLabel = UILabel()
    let priceLabel = UILabel()
    
    var compoundNumArray = [UILabel]()
    
    var model: RankDataModel! {
        didSet {
            self.thLabel.text = String(self.model.th) + " 회"
            self.rankLabel.text = String(self.model.rank) + "위"
            self.priceLabel.text = String(self.model.money) + "원"
            for (idx,value) in compoundNumArray.enumerated() {
                value.text = String(self.model.originBallNums[idx])
                value.backgroundColor = Lottori.setupBallColor(ballText: value.text!)
            }
            for idx in self.model.equalBallIdx.indices {
                self.compoundNumArray[idx].layer.borderColor = UIColor.black.cgColor
                self.compoundNumArray[idx].layer.borderWidth = 2
                self.compoundNumArray[idx].alpha = 1
            }
            
            
            // 나머지 셀에 알파값 0.5 주기
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutoLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure() {
        
        thLabel.text = "890"
        thLabel.textAlignment = .center
        thLabel.font = UIFont.boldSystemFont(ofSize: 23)
        contentView.addSubview(thLabel)
        
        contentView.addSubview(compoundNumView)
        
        rankLabel.layer.borderWidth = 1
        rankLabel.layer.borderColor = UIColor.black.cgColor
        rankLabel.layer.cornerRadius = 5
        rankLabel.textColor = .black
        rankLabel.textAlignment = .center
        rankLabel.text = "5위"
        contentView.addSubview(rankLabel)
        
        priceLabel.textColor = .black
        priceLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        priceLabel.text = "\(5000)원"
        contentView.addSubview(priceLabel)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        for label in compoundNumArray {
            label.layer.cornerRadius = label.frame.width / 2
            label.layer.masksToBounds = true
        }
    }
    
    func setAutoLayout() {
        thLabel.layout
            .centerY(equalTo: contentView.centerYAnchor)
            .leading(equalTo: contentView.leadingAnchor, constant: 5)
            .widthAnchor.constraint(equalToConstant: 70).isActive = true
        thLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        compoundNumView.layout
            .top(equalTo: contentView.topAnchor)
            .leading(equalTo: thLabel.trailingAnchor, constant: 5)
            .trailing(equalTo: contentView.trailingAnchor)
            .heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6).isActive = true
        
        for i in 0...5 {
            
            let compoundNumLabel = UILabel()
            compoundNumLabel.textAlignment = .center
            compoundNumLabel.textColor = .black
            compoundNumLabel.alpha = 0.5
            
            compoundNumView.addSubview(compoundNumLabel)
            
            if i == 0 {
                compoundNumLabel.layout.leading(equalTo: compoundNumView.leadingAnchor, constant: 2)
            } else {
                compoundNumLabel.layout.leading(equalTo: compoundNumArray[i-1].trailingAnchor, constant: 3.5)
            }
            
            compoundNumLabel
                .centerY(equalTo: compoundNumView.centerYAnchor)
                .widthAnchor.constraint(equalTo:compoundNumView.widthAnchor, multiplier: 1 / 9).isActive = true
            compoundNumLabel.heightAnchor.constraint(equalTo: compoundNumLabel.widthAnchor).isActive = true
            compoundNumLabel.textAlignment = .center
            
            compoundNumArray.append(compoundNumLabel)
        }
        
        rankLabel.layout
            .top(equalTo: compoundNumView.bottomAnchor)
            .leading(equalTo: compoundNumView.leadingAnchor, constant: 5)
            .widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        priceLabel.layout.top(equalTo: compoundNumView.bottomAnchor).trailing(constant: -10).bottom()
    }
}

