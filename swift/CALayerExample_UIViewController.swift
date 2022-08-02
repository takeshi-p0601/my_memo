import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = CALayer()
              
        // 25 -> 一つの場合、25,25,25...
        // 25,50 -> 25,50,25,50,25...
        let lineDashPatterns: [[NSNumber]?]  = [[25]]
             
        for (index, lineDashPattern) in lineDashPatterns.enumerated() {
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.lineWidth = 10
            shapeLayer.lineDashPhase = 15
            shapeLayer.lineDashPattern = lineDashPattern
            
            let path = CGMutablePath()
            let y = CGFloat((index + 1) * 50)
            path.addLines(between: [CGPoint(x: 0, y: y),
                                    CGPoint(x: 640, y: y)])
            
            shapeLayer.path = path
            
            layer.addSublayer(shapeLayer)
        }
        
        view.layer.addSublayer(layer)
    }


}
