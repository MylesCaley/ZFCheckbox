//
//  Checkbox.swift
//  ZFCheckbox
//
//  Created by Myles Caley on 3/10/16.
//
//

import UIKit

@objc class Checkbox: UIControl {
  
  var lineWidth:CGFloat?
  var lineColor:UIColor?
  var lineBackgroundColor:UIColor?
  var animateDuration:CFTimeInterval?
  var line1Layer:CAShapeLayer?
  var line2Layer:CAShapeLayer?
  
  static let kLine1UnselectedStart = CGFloat(0.2)
  static let kLine1UnselectedEnd = CGFloat(1.0)
  static let kLine1SelectedStart = CGFloat(0.0)
  static let kLine1SelectedEnd = CGFloat(0.08)
  
  static let kLine2UnselectedStart = CGFloat(0.41)
  static let kLine2UnselectedEnd = CGFloat(1.0)
  static let kLine2SelectedStart = CGFloat(0.0)
  static let kLine2SelectedEnd = CGFloat(0.28)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    
    // default
    self.lineWidth = 2;
    self.lineColor = .orangeColor()
    self.lineBackgroundColor = UIColor(white: 1, alpha: 0.3)
    self.animateDuration = 0.4;
    
    self.line1Layer = CAShapeLayer(layer: self.layer)
    self.line2Layer = CAShapeLayer(layer: self.layer)
    
    self.layer.addSublayer(line1Layer!)
    self.layer.addSublayer(line2Layer!)
    
    self.selected = false
  }
  
  override func drawRect(rect: CGRect) {
    let insetRect = CGRectInset(rect, self.lineWidth!, self.lineWidth!);
    let path = UIBezierPath(ovalInRect: insetRect)
    
    path.lineWidth = self.lineWidth!
    self.lineBackgroundColor!.setStroke()
    path.stroke()
  }
  
  override var selected: Bool {
    willSet(newValue) {
     print("changing from \(selected) to \(newValue)")
    }
    
    didSet {
      print("changed")
      super.selected = selected
      CATransaction.begin()
      CATransaction.setAnimationDuration(self.animateDuration!)
      if (self.selected) {
        self.line1Layer!.strokeStart = Checkbox.kLine1SelectedStart
        self.line1Layer!.strokeEnd = Checkbox.kLine1SelectedEnd
        self.line2Layer!.strokeStart = Checkbox.kLine2SelectedStart
        self.line2Layer!.strokeEnd = Checkbox.kLine2SelectedEnd
      } else {
        self.line1Layer!.strokeStart = Checkbox.kLine1UnselectedStart
        self.line1Layer!.strokeEnd = Checkbox.kLine1UnselectedEnd
        self.line2Layer!.strokeStart = Checkbox.kLine2UnselectedStart
        self.line2Layer!.strokeEnd = Checkbox.kLine2UnselectedEnd
      }
      CATransaction.commit()
    }
  }
  
  override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
    super.endTrackingWithTouch(touch, withEvent: event)
    
    if (CGRectContainsPoint(self.bounds,touch!.locationInView(self)))
    {
      self.selected = !self.selected
      self.sendActionsForControlEvents(.ValueChanged)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.line1Layer!.strokeColor = self.lineColor!.CGColor
    self.line2Layer!.strokeColor = self.lineColor!.CGColor
    
    
    self.line1Layer!.fillColor = UIColor.clearColor().CGColor
    self.line2Layer!.fillColor = UIColor.clearColor().CGColor
    
    self.line1Layer!.lineCap = kCALineCapRound
    self.line2Layer!.lineCap = kCALineCapRound
    
    self.line1Layer!.lineJoin = kCALineJoinRound
    self.line2Layer!.lineJoin = kCALineJoinRound
    
    self.line2Layer!.lineWidth = self.lineWidth!
    self.line1Layer!.lineWidth = self.lineWidth!
    
    let center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
    let insetRect = CGRectInset(self.bounds, self.lineWidth!, self.lineWidth!)
    let radius = (CGRectGetWidth(insetRect) > CGRectGetHeight(insetRect) ? CGRectGetHeight(insetRect) : CGRectGetWidth(insetRect)) / 2.0
    let startPoint = CGPointMake(center.x - 0.25 * radius, center.y + 0.45 * radius)
    
    let angle1 = CGFloat(13 * M_PI/12)
    let angle2 = CGFloat(9 * M_PI/5)
//    
    let path1 = UIBezierPath()
    path1.moveToPoint(startPoint)
    path1.addArcWithCenter(center, radius: radius, startAngle: angle1, endAngle: angle2, clockwise: false)
    
    let path2 = UIBezierPath()
    path2.moveToPoint(startPoint)
    path2.addArcWithCenter(center, radius: radius, startAngle: angle2, endAngle: angle1, clockwise: false)
    
    self.line1Layer!.path = path1.CGPath
    self.line2Layer!.path = path2.CGPath
    
    
    
  }

}
