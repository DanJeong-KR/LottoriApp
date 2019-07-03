
import UIKit

final class FirstView: UIView {
    
    var latestNumberView = UIView()
        let latestNumImageView = UIImageView()
        var dateLabel = UILabel()
        var roundNumberLabel = UILabel()
        var winNumberLabels: [UILabel] = []
        var plusLabel = UILabel()
    
    var qrButton = UIButton(type: .custom)
    var randomButton = UIButton(type: .custom)
    var userInputButton = UIButton(type: .custom)
    
    var interViewImageView = UIImageView()
    
    var model: LottoDataModel! {
        didSet {
            dateLabel.text = self.model.date
            roundNumberLabel.text = String(self.model.round) + " 회차"
            
            winNumberLabels[0].text = String(self.model.num1)
            winNumberLabels[1].text = String(self.model.num2)
            winNumberLabels[2].text = String(self.model.num3)
            winNumberLabels[3].text = String(self.model.num4)
            winNumberLabels[4].text = String(self.model.num5)
            winNumberLabels[5].text = String(self.model.num6)
            winNumberLabels[6].text = String(self.model.numBonus)
            
            winNumberLabels.forEach{ $0.backgroundColor = Lottori.setupBallColor(ballText: $0.text!) }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createNumberLabels()
        viewConfigure()
        buttonConfigure()
        autolayouts()
    }
    
    // 피드백 : 시점 문제
    // draw 함수를 사용하면 시점문제를 해결할 수 있다. 뷰가 가장 마지막에 그려지는 시점
    // update contraint 메소드로 해결해보기. 레이아웃을 잡히고 난 시점
    override func layoutSubviews() {
        super.layoutSubviews()
        
        winNumberLabels.forEach { $0.layer.cornerRadius = $0.bounds.width / 2}
    }
    
    
    
    private func createNumberLabels() {
        // 당첨번호 표현할 View 인스턴스들 생성할 것.
        for _ in 1...7 {
            let lb = UILabel()
            winNumberLabels.append(lb)
            lb.textColor = .white
            lb.textAlignment = .center
            lb.font = UIFont.systemFont(ofSize: 23, weight: .medium)
            lb.clipsToBounds = true // clipsToBounds 잊지 마라.
        }
        plusLabel.backgroundColor = .clear
        plusLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        plusLabel.text = "보너스 숫자 +"
        plusLabel.textAlignment = .center
        plusLabel.textColor = .black
    }
    
    private func viewConfigure() {
        
        addSubviews([latestNumberView,interViewImageView])
        backgroundColor = .white
        
        latestNumberView.addSubviews([latestNumImageView,dateLabel, roundNumberLabel, plusLabel])
        latestNumberView.addSubviews(winNumberLabels)
        
        dateLabel.textColor = .black
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        roundNumberLabel.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        roundNumberLabel.textColor = .black
        
        //imageView
        interViewImageView.layer.borderColor = UIColor.gray.cgColor
        interViewImageView.layer.borderWidth = 2
        interViewImageView.layer.cornerRadius = 24
        interViewImageView.layer.masksToBounds = true
        
        interViewImageView.animationImages = Lottori.image
        interViewImageView.animationDuration = 24 // 4초에 30장
        interViewImageView.startAnimating()
        
        latestNumImageView.image = UIImage(named: "green")
        latestNumImageView.contentMode = .scaleAspectFill
        latestNumImageView.clipsToBounds = true
    }
    
    private func buttonConfigure() {
        addSubviews([ qrButton, randomButton, userInputButton])
        
        qrButton.setImage(UIImage(named: "qrcode"), for: .normal)
        qrButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        qrButton.addTarget(self, action: #selector(qrButtonDidTapped(_:)), for: .touchUpInside)
        
        randomButton.backgroundColor = .white
        randomButton.setBackgroundImage(UIImage(named: "random"), for: .normal)
        randomButton.imageView?.contentMode = .scaleAspectFit
        randomButton.addTarget(self, action: #selector(randomButtonDidTapped(_:)), for: .touchUpInside)
        
        userInputButton.backgroundColor = .white
        userInputButton.setBackgroundImage(UIImage(named: "userInput"), for: .normal)
        userInputButton.imageView?.contentMode = .scaleAspectFit
        userInputButton.addTarget(self, action: #selector(userInputButtonDidTapped(_:)), for: .touchUpInside)
    }
    
    //MARK: - 오토레이아웃 !
    private func autolayouts() {
        
        latestNumberView.layout.top().leading().trailing()
        latestNumberView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // latestNumberView 안에 객체들 레이아웃
        dateLabel.layout.top(constant: 15).centerX()
        roundNumberLabel.layout.top(equalTo: dateLabel.bottomAnchor, constant: 5).centerX()
        
        for (idx,label) in winNumberLabels.enumerated() {
            if idx != 6 {
                label.layout.top(equalTo: roundNumberLabel.bottomAnchor, constant: 5)
            }
            label.widthAnchor.constraint(equalToConstant: 50).isActive = true
            label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        for (idx,label) in winNumberLabels.enumerated() {
            if idx != 6 && idx != 5 {
                label.trailing(equalTo: winNumberLabels[idx + 1].leadingAnchor, constant: -10)
            }
        }
        winNumberLabels.first!.centerX(constant: -152)
        
        plusLabel.layout.top(equalTo: winNumberLabels.first!.bottomAnchor, constant: 13).centerX(constant: -50)
        
        winNumberLabels.last!.layout.top(equalTo: winNumberLabels.first!.bottomAnchor, constant: 5).leading(equalTo: plusLabel.trailingAnchor, constant: 10)
        
        // qr코드 버튼
        qrButton.layout.top(equalTo: latestNumberView.bottomAnchor, constant: 10).centerX()
        qrButton.heightAnchor.constraint(equalToConstant: 170).isActive = true
        qrButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        //직접 버튼
        userInputButton.layout
            .top(equalTo: qrButton.bottomAnchor, constant: 20)
            .centerX(equalTo: self.centerXAnchor, constant: -70)
        userInputButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        userInputButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        //random Button
        randomButton.layout.top(equalTo: qrButton.bottomAnchor, constant: 20).centerX(equalTo: self.centerXAnchor, constant: 70)
        randomButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        randomButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        //imageView
        interViewImageView.layout
            .top(equalTo: randomButton.bottomAnchor, constant: 15)
            .leading(constant: 5)
            .trailing(constant: -5)
            .top(equalTo: userInputButton.bottomAnchor, constant: 15)
        interViewImageView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        //imageView - 클로버 이미지
        latestNumImageView.layout
            .top(equalTo: latestNumberView.topAnchor)
            .leading(equalTo: latestNumberView.leadingAnchor)
            .trailing(equalTo: latestNumberView.trailingAnchor)
            .bottom(equalTo: latestNumberView.bottomAnchor)
    }
    
    //MARK: - 버튼 액션 메소드
    
    // 노티피케이션 보다 델리게이트가 적절한 
    @objc private func qrButtonDidTapped(_ sender: Any) {
        noti.post(name: Notification.Name(rawValue: "qrButtonDidTapped"), object: nil)
    }
    
    @objc private func randomButtonDidTapped(_ sender: Any) {
        noti.post(name: Notification.Name(rawValue: "randomButtonDidTapped"), object: nil)
    }
    
    @objc private func userInputButtonDidTapped(_ sender: Any) {
        noti.post(name: Notification.Name(rawValue: "userInputButtonDidTapped"), object: nil)
    }
}
