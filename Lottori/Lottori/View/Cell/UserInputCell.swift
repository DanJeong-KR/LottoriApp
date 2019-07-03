//
//  UserInputCell.swift
//  Lottori
//
//  Created by Solji Kim on 22/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

protocol UserInputCellDelegate: class {
    func ballAction(cell: UserInputCell)
}

class UserInputCell: UICollectionViewCell {
    
    weak var delegate: UserInputCellDelegate?
    
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
        delegate?.ballAction(cell: self)
    }
    
    func layout() {
        ball.translatesAutoresizingMaskIntoConstraints = false
        ball.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        ball.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        ball.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        ball.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
