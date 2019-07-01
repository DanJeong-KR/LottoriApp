
import UIKit

private struct Standard {
    static let space: CGFloat = 0
    static let size: CGFloat = 330
    static let toSpace: CGFloat = 5
}

class UserInputViewController: UIViewController {
    
    let selectedBallView = UIView()
    let resetButton = UIButton()
    let makeButton = UIButton()
    let showBallView = UIView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let selectedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let alertLable = UILabel()
    
    private var userNotiLabel = UILabel()
    
    let titleImageView = UIImageView(image: UIImage(named: "title"))
 
    var ballNumbers = Array(1...45)
    
    var ballState: [Bool] = {
        var temp: [Bool] = []
        for _ in 0..<45 {
            temp.append(false)
        }
        return temp
    }()
    
    var arrayForBallsUserSelected = [Int]()
    
    var labels: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "직접 생성"
        navigationItem.titleView = titleImageView
        titleImageView.contentMode = .scaleAspectFit
        
        collectionView.dataSource = self
        collectionView.register(UserInputCell.self, forCellWithReuseIdentifier: "userInput")
        
        selectedCollectionView.dataSource = self
        selectedCollectionView.register(UserInputCell.self, forCellWithReuseIdentifier: "select")
        
        configure()
        setAutoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5) {
            self.userNotiLabel.alpha = 0.9
        }
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
            
            let selectCellWidth: CGFloat = (200 - (Standard.toSpace * 5)) / 6
            let selectLayout = selectedCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            
            selectLayout.itemSize = CGSize(width: selectCellWidth, height: selectCellWidth)
            selectLayout.scrollDirection = .horizontal
            selectLayout.minimumLineSpacing = Standard.toSpace
            selectLayout.minimumInteritemSpacing = Standard.toSpace
            selectedCollectionView.contentInset = UIEdgeInsets(top: Standard.space, left: Standard.space, bottom: Standard.space, right: Standard.space)
        }
        layoutState = false
    }
    
    
    func configure() {
        selectedBallView.backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        view.addSubview(selectedBallView)
        
        resetButton.setTitle("초기화", for: .normal)
        resetButton.setTitleColor(.black, for: .normal)
        resetButton.addTarget(self, action: #selector(initializeDidTap(_:)), for: .touchUpInside)
        view.addSubview(resetButton)
        
        makeButton.setTitle("생성하기", for: .normal)
        makeButton.setTitleColor(.black, for: .normal)
        makeButton.addTarget(self, action: #selector(makeButtonDidTapped(_:)), for: .touchUpInside)
        view.addSubview(makeButton)
        
        showBallView.backgroundColor = #colorLiteral(red: 0.8931968306, green: 0.9020403636, blue: 0.9020403636, alpha: 1)
        view.addSubview(showBallView)
        
        collectionView.tag = 0
        collectionView.backgroundColor = .clear
        showBallView.addSubview(collectionView)
        
        selectedCollectionView.tag = 1
        selectedCollectionView.backgroundColor = .white
        view.addSubview(selectedCollectionView)
        
        alertLable.backgroundColor = #colorLiteral(red: 0.3264555857, green: 0.3296878192, blue: 0.3296878192, alpha: 1)
        alertLable.alpha = 0
        alertLable.textColor = .white
        alertLable.textAlignment = .center
        alertLable.layer.cornerRadius = 20
        alertLable.layer.masksToBounds = true
        view.addSubview(alertLable)
        
        userNotiLabel.backgroundColor = #colorLiteral(red: 0.6425128163, green: 0.8382837176, blue: 1, alpha: 1)
        userNotiLabel.alpha = 0
        userNotiLabel.textAlignment = .center
        userNotiLabel.layer.cornerRadius = 20
        userNotiLabel.layer.masksToBounds = true
        userNotiLabel.numberOfLines = 0
        userNotiLabel.font = UIFont.boldSystemFont(ofSize: 20)
        userNotiLabel.text = "최근 15주간 미출현 번호\n\n\n최근 15주간 가장 많이 출현한 번호\n\n"
        view.addSubview(userNotiLabel)
        
        for i in 0...5 {
            let lb = UILabel()
            userNotiLabel.addSubview(lb)
            if i <= 2 {
                lb.text = String(FixedData.notShowingNum[i])
            }else {
                lb.text = String(FixedData.showingNum[i-3])
            }
            lb.backgroundColor = Lottori.setupBallColor(ballText: lb.text!)
            lb.textAlignment = .center
            lb.font = UIFont.boldSystemFont(ofSize: 25)
            lb.layer.cornerRadius = 35 / 2
            lb.layer.masksToBounds = true
            labels.append(lb)
        }
        
    }
    
    // MARK: - 오토레이아웃
    func setAutoLayout() {
        
        let guide = view.safeAreaLayoutGuide
        
        selectedBallView.layout
            .top(constant: 70)
            .leading(constant: 20)
            .widthAnchor.constraint(equalToConstant: 200).isActive = true
        selectedBallView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        makeButton.layout
            .top(constant: 30)
            .leading(equalTo: selectedBallView.trailingAnchor, constant: 15)
            .heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        resetButton.layout
            .top(constant: 30)
            .leading(equalTo: makeButton.trailingAnchor, constant: 10)
            .centerY(equalTo: makeButton.centerYAnchor)
            .heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        showBallView.layout
            .top(equalTo: selectedBallView.bottomAnchor, constant: 40)
            .centerX(equalTo: guide.centerXAnchor)
            .heightAnchor.constraint(equalToConstant: Standard.size).isActive = true
        showBallView.layout.widthAnchor.constraint(equalToConstant: Standard.size).isActive = true
        
        collectionView.layout
            .top(equalTo:showBallView.topAnchor)
            .leading(equalTo:showBallView.leadingAnchor)
            .bottom(equalTo:showBallView.bottomAnchor)
            .trailing(equalTo:showBallView.trailingAnchor)
        

        selectedCollectionView.layout
            .bottom(equalTo: selectedBallView.topAnchor)
            .leading(equalTo: selectedBallView.leadingAnchor)
            .trailing(equalTo: selectedBallView.trailingAnchor)
            .heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        alertLable.layout
            .centerX()
            .bottom(constant: -20)
            .heightAnchor.constraint(equalToConstant: 60).isActive = true
        alertLable.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        userNotiLabel.layout
            .centerX()
            .top(equalTo: collectionView.bottomAnchor, constant: 10)
            .widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
        userNotiLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        for idx in 0...2 {
            labels[idx].layout.top(equalTo: userNotiLabel.topAnchor, constant: 30)
            labels[idx].widthAnchor.constraint(equalToConstant: 35).isActive = true
            labels[idx].heightAnchor.constraint(equalToConstant: 35).isActive = true
        }
        labels[1].centerX()
        labels[0].centerX(constant: -50)
        labels[2].centerX(constant: 50)
        
        for idx in 3...5 {
            labels[idx].layout.top(equalTo: userNotiLabel.topAnchor, constant: 105)
            labels[idx].widthAnchor.constraint(equalToConstant: 35).isActive = true
            labels[idx].heightAnchor.constraint(equalToConstant: 35).isActive = true
        }
        labels[4].centerX()
        labels[3].centerX(constant: -50)
        labels[5].centerX(constant: 50)
        
        
    }
    
    // MARK: - 버튼 액션 메소드
    @objc func initializeDidTap(_ sender: UIButton) {
        
        arrayForBallsUserSelected.removeAll()
        for i in 0..<ballState.count {
            ballState[i] = false
        }
        
        selectedCollectionView.reloadData()
        collectionView.reloadData()
    }
    
    @objc func makeButtonDidTapped(_ sender: UIButton) {
        
        let rankVC = RankingViewController()
        
        guard arrayForBallsUserSelected.count >= 6 else {
            
            self.alertLable.alpha = 1
            alertLable.text = "6개의 번호를 선택하여야 합니다."
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 2) {
                    self.alertLable.alpha = 0
                }
            }
            return
        }
        
        //헤더 넘버 라벨 설정
        var numSelected = ""
        for i in 0..<arrayForBallsUserSelected.count {

            let text = (i == arrayForBallsUserSelected.count-1) ? String(arrayForBallsUserSelected[i])
                : String(arrayForBallsUserSelected[i]) + ", "

            numSelected += text
        }
        rankVC.headerNumLabel.text = numSelected
        
        rankVC.dataArr = Lottori.searchPastRanking(inputBallNums: arrayForBallsUserSelected.map{ String($0)})
        
        navigationController?.pushViewController(rankVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension UserInputViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return ballNumbers.count
        } else {
            return arrayForBallsUserSelected.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userInput", for: indexPath) as! UserInputCell

            cell.delegate = self
            
            cell.ball.backgroundColor = #colorLiteral(red: 0.7792800315, green: 0.7948656321, blue: 0.7948656321, alpha: 1)
            cell.ball.setTitleColor(.white, for: .normal)
            cell.ball.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            cell.ball.layer.borderWidth = 1
            cell.ball.layer.borderColor = UIColor.white.cgColor
            cell.ball.setTitle(String(ballNumbers[indexPath.row]), for: .normal)
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "select", for: indexPath) as! UserInputCell
            
            cell.ball.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
            cell.ball.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            cell.ball.setTitle(String(arrayForBallsUserSelected[indexPath.row]), for: .normal)
            cell.ball.backgroundColor = Lottori.setupBallColor(ballText: String(arrayForBallsUserSelected[indexPath.row]))
            
            return cell
        }
    }  
}


// MARK: - UserInputCellDelegate

extension UserInputViewController: UserInputCellDelegate {
    
    func ballAction(cell: UserInputCell) {
        
        let indexPath = collectionView.indexPath(for: cell)
        let index = arrayForBallsUserSelected.firstIndex(of: Int(cell.ball.currentTitle!)!)
        
        guard !arrayForBallsUserSelected.contains(Int(cell.ball.currentTitle!)!) else {
            arrayForBallsUserSelected.remove(at: index!)
            selectedCollectionView.reloadData()
            cell.ball.backgroundColor = #colorLiteral(red: 0.7792800315, green: 0.7948656321, blue: 0.7948656321, alpha: 1)
            cell.ball.setTitleColor(.white, for: .normal)
            cell.ball.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            cell.ball.layer.borderWidth = 1
            cell.ball.layer.borderColor = UIColor.white.cgColor
            return
        }
        
        guard arrayForBallsUserSelected.count < 6 else {
            
            self.alertLable.alpha = 1
            alertLable.text = "6개까지만 선택 가능합니다."
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 2) {
                    self.alertLable.alpha = 0
                }
            }
            return
        }
        
        ballState[(indexPath?.row)!].toggle()

        if ballState[(indexPath?.row)!] {
            cell.ball.backgroundColor = .white
            cell.ball.setTitleColor(.black, for: .normal)
            cell.ball.layer.borderWidth = 2.5
            cell.ball.layer.borderColor = UIColor.yellow.cgColor
            
        } else {
            cell.ball.backgroundColor = #colorLiteral(red: 0.7792800315, green: 0.7948656321, blue: 0.7948656321, alpha: 1)
            cell.ball.setTitleColor(.white, for: .normal)
            cell.ball.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            cell.ball.layer.borderWidth = 1
            cell.ball.layer.borderColor = UIColor.white.cgColor
        }
        
        guard !arrayForBallsUserSelected.contains(Int(cell.ball.currentTitle!)!) else {
            arrayForBallsUserSelected.remove(at: index!)
            selectedCollectionView.reloadData()
            return
        }
        
        arrayForBallsUserSelected.append(Int(cell.ball.currentTitle!)!) // title arr
        arrayForBallsUserSelected.sort()
        selectedCollectionView.reloadData()
        
        
    }
}


