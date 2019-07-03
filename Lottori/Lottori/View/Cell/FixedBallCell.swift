//
//  FixedBallCell.swift
//  Lottori
//
//  Created by Solji Kim on 23/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

protocol FixedBallDelegate {
    func actionBall(cell: FixedBallCell)
}

class FixedBallCell: UICollectionViewCell {
    
    var delegate: FixedBallDelegate?
    
    var ballTitleColor: UIColor! {
        didSet{
            self.ball.setTitleColor(self.ballTitleColor, for: .normal)
        }
    }
    
    let ball = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ball.layer.cornerRadius = contentView.frame.width / 2
        ball.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        ball.backgroundColor = #colorLiteral(red: 0.7792800315, green: 0.7948656321, blue: 0.7948656321, alpha: 1)
        ball.titleLabel?.textAlignment = .center
        ball.setTitleColor(.white, for: .normal)
        ball.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        ball.layer.borderWidth = 1
        ball.layer.borderColor = UIColor.white.cgColor
        ball.addTarget(self, action: #selector(ballDidTap), for: .touchUpInside)
        
        contentView.addSubview(ball)
    }
    
    @objc func ballDidTap(_ sender: UIButton) {
        delegate?.actionBall(cell: self)
    }
    
    func layout() {
        ball.translatesAutoresizingMaskIntoConstraints = false
        ball.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        ball.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        ball.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        ball.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
