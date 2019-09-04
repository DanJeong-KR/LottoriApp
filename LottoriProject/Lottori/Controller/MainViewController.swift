//
//  FirstViewController.swift
//  Lottori
//
//  Created by chang sic jung on 21/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//


import UIKit
import SafariServices
import FirebaseDatabase

final class MainViewController: UIViewController {
    
    let titleImageView = UIImageView(image: UIImage(named: "title"))
    let firstView = FirstView()
    
    private var lottoRound = 860
    let date = Date()
    
    // MARK: - 뷰 라이프 사이클 -----------
    override func viewDidLoad() {
        super.viewDidLoad()
      
      //test
      var ref: DatabaseReference
      ref = Database.database().reference()
      
      ref.child("archiveData").observe(.value) { (snapshot) in
        let value = snapshot.value as? [String : Any]
        print("value : \(value)")
      }
      
      ref.child("archiveData").setValue(["2" : ["bonus" : 7, "number" : ["1", "2"]]])
      ref.child("archiveData").updateChildValues(["3" : ["bonus" : 7, "number" : ["1", "2"]]])
      
      
      
      
      
        configure()
        getLottoAPI()
        
        notificationObservers()
        
        
        // 이벤트만 전달시 addtarget 으로 가능.
        // firstView.qrButton.addTarget(self, action: #selec, for: <#T##UIControl.Event#>)
    }
  
  func setData(num: Int) {
    let urlString = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=" + String(num)
    let url = URL(string: urlString)!
    
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
      let jsonObject = JSONSerialization.jsonObject(with: data!, options: <#T##JSONSerialization.ReadingOptions#>)
    }
  }
    
    override func viewDidAppear(_ animated: Bool) {
        // 시점 문제 해결하려고
        
        // 직접 부르는 거 아니다.
        view.layoutSubviews()
    }
    //----------------------------------
    
    // MARK: - 객체들 configure -------
    private func configure() {
        view = firstView
        navigationItem.titleView = titleImageView
        titleImageView.contentMode = .scaleAspectFit
    }
    //--------------------------------
    
    // MARK: - notificationObservers-----
    private func notificationObservers() {
        noti.addObserver(self, selector: #selector(observerActionFunc(_:)), name: Notification.Name("qrButtonDidTapped"), object: nil)
        noti.addObserver(self, selector: #selector(observerActionFunc(_:)), name: Notification.Name("randomButtonDidTapped"), object: nil)
        noti.addObserver(self, selector: #selector(observerActionFunc(_:)), name: Notification.Name("userInputButtonDidTapped"), object: nil)
    }
    
    @objc private func observerActionFunc(_ sender: Notification) {
        
        switch sender.name.rawValue {
        case "qrButtonDidTapped":
            show(QRCodeScanningViewController(), sender: nil)
        case "randomButtonDidTapped":
            show(RandomViewController(), sender: nil)
        case "userInputButtonDidTapped":
            show(UserInputViewController(), sender: nil)
        default:
            break
        }
    }
    // -----------------------------------
    
    //
    private func getLottoAPI() {
        
        // 일주일이 지나면 횟차가 올라가고 자동으로 api 를 받는다.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = dateFormatter.date(from:"2019-05-25")!
        let endDate = date
        
        let interval = endDate.timeIntervalSince(startDate)
        let days = Int(interval / 86400)
        
        if days >= 7 {
            lottoRound += 1
        }
        
            
        DispatchQueue.global().async {
            let request = NSMutableURLRequest(url: NSURL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=" + String(self.lottoRound))! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    let data = try? JSONDecoder().decode(LottoriCodable.self, from: data!)
                    DispatchQueue.main.async {
                        
                        self.firstView.model = LottoDataModel(date: data!.drwNoDate,
                                                              round: data!.drwNo,
                                                              num1: data!.drwtNo1,
                                                              num2: data!.drwtNo2,
                                                              num3: data!.drwtNo3,
                                                              num4: data!.drwtNo4,
                                                              num5: data!.drwtNo5,
                                                              num6: data!.drwtNo6,
                                                              numBonus: data!.bnusNo)
                    }
                }
            })
            dataTask.resume()
        }
        
    }
    
}
