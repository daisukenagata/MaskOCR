//
//  MaskOCRHhollowTargetLayer.swift
//  SampleFocus
//
//  Created by 永田大祐 on 2018/06/30.
//  Copyright © 2018年 永田大祐. All rights reserved.
//

import UIKit

@available(iOS 14.0.0, *)
final public class MaskOCRHhollowTargetLayer: UIView {

    public var opacity: Float = 0.7
    public var borderWidth: CGFloat = 1
    public var borderColor: UIColor = .white
    public var backColor: UIColor = .black
    
    var hollowTargetLayer: CALayer?

    private var path:  UIBezierPath?
    private var maskLayer: CAShapeLayer?

    override public init(frame: CGRect) {
        super.init(frame: .zero)

        self.frame = UIScreen.main.bounds

        hollowTargetLayer = CALayer()
        maskLayer = CAShapeLayer()
        path = UIBezierPath()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func tori(_ gesture: MaskOCRGestureViewModel){
        guard let hollowTargetLayer = hollowTargetLayer,
                let maskLayer = maskLayer
            else { return }

        gesture.lineView.layer.borderWidth = borderWidth
        gesture.lineView.layer.borderColor = borderColor.cgColor

        hollowTargetLayer.bounds = self.bounds
        hollowTargetLayer.position = CGPoint(
            x: self.bounds.width / 2.0,
            y: self.bounds.height / 2.0
        )

        hollowTargetLayer.backgroundColor = backColor.cgColor
        hollowTargetLayer.opacity = opacity

        maskLayer.bounds = hollowTargetLayer.bounds

        path = UIBezierPath.init(rect: gesture.lineView.frame)
        path?.append(UIBezierPath(rect: maskLayer.bounds))

        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.path = path?.cgPath
        maskLayer.position = CGPoint(
            x: hollowTargetLayer.bounds.width / 2.0,
            y: (hollowTargetLayer.bounds.height / 2.0)
        )

        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        hollowTargetLayer.mask = maskLayer
    }
}
