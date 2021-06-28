//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        setupViews()
    }
    
    private func setupViews() {
        
        self.view = getRootView()
        let redView = getRedView()
        // Поворот redView
        redView.transform = CGAffineTransform(rotationAngle: .pi/3)
        
        let greenView = getGreenView()
        set(view: greenView, toCenterOfView: redView)
        
        let whiteView = getWhiteView()
        whiteView.center = greenView.center
        
        let pinkView = getPinkView()
        
        self.view.addSubview(redView)
        redView.addSubview(greenView)
        redView.addSubview(whiteView)
        self.view.addSubview(pinkView)
    }
    
    private func set(view moveView: UIView, toCenterOfView baseView: UIView) {
        moveView.center = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
    }
    
    
    private func getRootView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }
    
    private func getRedView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 50, width: 200, height: 200)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
        
    }
    
    private func getGreenView() -> UIView {
        let frame = CGRect(x: 10, y: 10, width: 180, height: 180)
        let view = UIView(frame: frame)
        view.backgroundColor = .green
        return view
    }
    
    private func getWhiteView() -> UIView {
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let view = UIView(frame: frame)
        view.backgroundColor = .white
        return view
    }
    
    private func getPinkView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 300, width: 100, height: 100)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .systemPink
        
        // ширина рамки
        view.layer.borderWidth = 5
        // цвет рамки
        view.layer.borderColor = UIColor.yellow.cgColor
        // скругление углов
        view.layer.cornerRadius = 10
        // насколько видна тень от 0,0 до 1,0
        view.layer.shadowOpacity = 0.95
        // радиус размытия тени, чем больше, тем более размыто
        view.layer.shadowRadius = 10
        // смещение тени
        view.layer.shadowOffset = CGSize(width: 10, height: 20)
        // цвет тени
        view.layer.shadowColor = UIColor.white.cgColor
        // прозрачность
        view.layer.opacity = 0.7
        // цвет фона
        view.layer.backgroundColor = UIColor.black.cgColor
        
        view.layer.backgroundColor = UIColor.systemPink.cgColor
        view.layer.opacity = 1
        
        // создание дочернего слоя
        let layer = CALayer()
        layer.backgroundColor = UIColor.black.cgColor
        layer.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        layer.cornerRadius = 10
        view.layer.addSublayer(layer)
        
        // вывод на консоль размеров представления
        print(view.frame)
        // поворот представления
        view.transform = CGAffineTransform(rotationAngle: .pi/4)
        // растягиваем
        view.transform = CGAffineTransform(scaleX: 1.5, y: 0.7)
        // смещение на указанное количество точек
        view.transform = CGAffineTransform(translationX: 100, y: 5)
        // возвращаем все в изначальное состояние
        view.transform = CGAffineTransform.identity
        
        
        return view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
