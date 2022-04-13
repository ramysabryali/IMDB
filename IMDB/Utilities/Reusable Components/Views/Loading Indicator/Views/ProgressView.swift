//
//  ProgressView.swift
//  IMDB
//
//  Created by Ramy Sabry on 13/04/2022.
//

import UIKit

public class ProgressView: UIView {
    private var progress: CGFloat = 0
    private var layerCircle = CAShapeLayer()
    private var layerProgress = CAShapeLayer()
    private var labelPercentage: UILabel = UILabel()
    
    public var color: UIColor = .systemBackground {
        didSet {
            setupLayers()
        }
    }

    // MARK: - Init
    convenience public init(_ color: UIColor) {
        self.init(frame: .zero)
        self.color = color
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupLayers()
    }
}

// MARK: - Methods

public extension ProgressView {
    func setupLayers() {
        subviews.forEach { $0.removeFromSuperview() }
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let width = frame.size.width
        let height = frame.size.height

        let center = CGPoint(x: width/2, y: height/2)
        let radiusCircle = width / 2
        let radiusProgress = width / 2 - 5

        let pathCircle = UIBezierPath(arcCenter: center, radius: radiusCircle, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)
        let pathProgress = UIBezierPath(arcCenter: center, radius: radiusProgress, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)

        layerCircle.path = pathCircle.cgPath
        layerCircle.fillColor = UIColor.clear.cgColor
        layerCircle.lineWidth = 3
        layerCircle.strokeColor = color.cgColor

        layerProgress.path = pathProgress.cgPath
        layerProgress.fillColor = UIColor.clear.cgColor
        layerProgress.lineWidth = 7
        layerProgress.strokeColor = color.cgColor
        layerProgress.strokeEnd = 0

        layer.addSublayer(layerCircle)
        layer.addSublayer(layerProgress)

        labelPercentage.frame = self.bounds
        labelPercentage.textColor = color
        labelPercentage.textAlignment = .center
        addSubview(labelPercentage)
    }

    func setProgress(_ value: CGFloat, duration: TimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progress
        animation.toValue = value
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        layerProgress.add(animation, forKey: "animation")

        progress = value
        labelPercentage.text = "\(Int(value*100))%"
    }
}
