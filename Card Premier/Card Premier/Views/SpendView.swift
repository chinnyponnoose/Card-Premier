//
//  SpendView.swift
//  Card Premier
//
//  Created by Chinny Ponnoose on 7/24/19.
//  Copyright © 2019 Chinny. All rights reserved.
//

import UIKit

class SpendView: UIView {

    private struct Constants {
        static let arcWidth: CGFloat = 15.0
        static let overAllLimit: CGFloat = 200
    }

    var spendPercentage = 0.0
    var pendingSpendPercentage = 0.0
    var spendCircleColor = UIColor(red: 97/255.0, green: 184/255.0, blue: 60/255.0, alpha: 1.0)
    var pendingSpendCircleColor = UIColor(red: 191/255.0, green: 183/255.0, blue: 60/255.0, alpha: 1.0)
    var backgroundCircleColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)

    override func draw(_ rect: CGRect) {
        drawBackgroundCircle()
        drawSpendCircle(with: pendingSpendPercentage, color: pendingSpendCircleColor)
        drawSpendCircle(with: spendPercentage, color: spendCircleColor)
    }

    func drawBackgroundCircle() {
        let trackLayer = CAShapeLayer()
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height)

        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4


        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - Constants.arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)

        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.path = path.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = backgroundCircleColor.cgColor
        trackLayer.lineWidth = Constants.arcWidth
        //trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)

    }
    func drawSpendCircle(with percentage: Double, color: UIColor) {

        let progressLayer = CAShapeLayer()
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        let arcLengthPerSpend = angleDifference / CGFloat(Constants.overAllLimit)
        let outlineEndAngle = arcLengthPerSpend * CGFloat(percentage) + startAngle
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - Constants.arcWidth/2,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)

        progressLayer.path = outlinePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = color.cgColor
        progressLayer.lineWidth = Constants.arcWidth
        progressLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(progressLayer)
        setProgressWithAnimation(duration: 2, percentage: percentage, layer: progressLayer)
    }
    func setProgressWithAnimation(duration: TimeInterval, percentage: Double, layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        layer.strokeEnd = CGFloat(percentage)
        layer.add(animation, forKey: "animateprogress")
    }


}
