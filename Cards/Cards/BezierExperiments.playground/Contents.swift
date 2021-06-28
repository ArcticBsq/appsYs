//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        self.view = view
        
        // создаем кривые на сцене
        createBezier(on: view, with: getPath())
        createBezier(on: view, with: getRect())
        createBezier(on: view, with: getHalfCircle())
        createBezier(on: view, with: getRound())
        createBezier(on: view, with: getOval())
        createBezier(on: view, with: getCurveLine())
    }
    
    
    func createBezier(on view: UIView, with path: UIBezierPath) {
        // 1
        // создаем графический контекст(слой)
        // на нем в дальнейшем будут рисоваться кривые
        let shapeLayer = CAShapeLayer()
        // 2
        // добавляем слой в качестве дочернего к корневому слою корневого представления
        view.layer.addSublayer(shapeLayer)
        // 3
        // изменение цвета линий
        shapeLayer.strokeColor = UIColor.gray.cgColor
        // изменение толщины линий
        shapeLayer.lineWidth = 5
        // определение фонового цвета
        shapeLayer.fillColor = nil
        // оформление крайних точек линий, из которых состоит фигура
        shapeLayer.lineCap = .round
        // стиль оформления соединительных точек
        shapeLayer.lineJoin = .round // .bevel .miter
        
        // 4
        // создание фигуры
        shapeLayer.path = path.cgPath
    }
    
    private func getPath() -> UIBezierPath {
        // 1
        let path = UIBezierPath()
        // 2
        path.move(to: CGPoint(x: 50, y: 50))
        // 3
        path.addLine(to: CGPoint(x: 150, y: 50))
        // рисуем вторую линию
        path.addLine(to: CGPoint(x: 150, y: 150))
        // можно закрыть фигуру, не рисуя вручную 3 линию
        path.close()
        
        // создание второго треугольника
        path.move(to: CGPoint(x: 50, y: 70))
        path.addLine(to: CGPoint(x: 150, y: 170))
        path.addLine(to: CGPoint(x: 50, y: 170))
        path.close()
        
        return path
    }
    
    private func getRect() -> UIBezierPath {
        // создание сущности прямоугольник
        let rect = CGRect(x: 10, y: 10, width: 200, height: 100)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomRight, .topLeft], cornerRadii: CGSize(width: 30, height: 0))
        return path
    }
    
    // cсоздаем полукруглую дугу
    private func getHalfCircle() -> UIBezierPath {
        let centerPoint = CGPoint(x: 200, y: 200)
        let path = UIBezierPath(arcCenter: centerPoint, radius: 150, startAngle: .pi/5, endAngle: .pi, clockwise: true)
        return path
    }
    
    // создаем круг
    private func getRound() -> UIBezierPath {
        let centerPoint = CGPoint(x: 200, y: 200)
        let path = UIBezierPath(arcCenter: centerPoint, radius: 77, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        return path
    }
    
    // создаем овал
    private func getOval() -> UIBezierPath {
        let rect = CGRect(x: 150, y: 500, width: 200, height: 100)
        let path = UIBezierPath(ovalIn: rect)
        return path
    }
    
    // создаем кривую
    private func getCurveLine() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 210))
        path.addCurve(to: CGPoint(x: 200, y: 400), controlPoint1: CGPoint(x: 200, y: 220), controlPoint2: CGPoint(x: 20, y: 400))
        return path
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
