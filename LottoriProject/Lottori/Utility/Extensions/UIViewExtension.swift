import UIKit

// MARK: - 배열로 addsubview 하기!
extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

// MARK: - AutoLayoutAnchor 쉽게잡기.
extension UIView {
    var layout: UIView {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    // @discardableResult : 이 아이를 사용하지 않아도 warning(노란색) 이 뜨지 않게 해주는 속성
    @discardableResult
    func top(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.topAnchor
        topAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    @discardableResult
    func leading(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.leadingAnchor
        leadingAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    @discardableResult
    func bottom(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.bottomAnchor
        bottomAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    @discardableResult
    func trailing(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.trailingAnchor
        trailingAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    @discardableResult
    func centerY(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.centerYAnchor
        centerYAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    @discardableResult
    func centerX(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.centerXAnchor
        centerXAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
  @discardableResult
  func height(equalTo anchor: NSLayoutDimension? = nil, constant c: CGFloat = 0, multiplier m: CGFloat = 1) -> Self {
    if let superview = superview {
      if c == 0 {
        let anchor = anchor ?? superview.safeAreaLayoutGuide.heightAnchor
        heightAnchor.constraint(equalTo: anchor, multiplier: m, constant: c).isActive = true
      } else {
        // FIXME: - contant 에 값을 주면 전체 높이에서 계산되는 문제
        heightAnchor.constraint(equalToConstant: c).isActive = true
      }
      return self
    } else {
      logger("\(ErrorLog.layout) : superview is nil")
      fatalError()
    }
  }
  
  @discardableResult
  func width(equalTo anchor: NSLayoutDimension? = nil, constant c: CGFloat = 0, multiplier m: CGFloat = 1) -> Self {
    if let superview = superview {
      if c == 0 {
        let anchor = anchor ?? superview.safeAreaLayoutGuide.heightAnchor
        heightAnchor.constraint(equalTo: anchor, multiplier: m, constant: c).isActive = true
      } else {
        heightAnchor.constraint(equalToConstant: c).isActive = true
      }
      return self
    } else {
      logger("\(ErrorLog.layout) : superview is nil")
      fatalError()
    }
  }
  
  func equalToSuperView() {
    if let superview = superview {
      leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
      rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
      topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
      bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    } else {
      logger("\(ErrorLog.layout) : superview is nil")
      fatalError()
    }
  }
}

// MARK: - frame 기반에서 UI 설정하기 쉽게 하기
extension UIView {
    var x: CGFloat {
        // self.x 로 쓰면되
        get { return frame.origin.x }
        set { frame.origin.x = newValue }
    }
    var y: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue }
    }
    var width: CGFloat {
        get { return frame.width }
        set { frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return frame.height }
        set { frame.size.height = newValue }
    }
    var origin: CGPoint {
        get { return frame.origin }
        set { frame.origin = newValue }
    }
    var size: CGSize {
        get { return frame.size }
        set { frame.size = newValue }
    }
    var maxX: CGFloat {
        return frame.origin.x + frame.size.width
    }
    var maxY: CGFloat {
        return frame.origin.y + frame.size.height
    }
}
