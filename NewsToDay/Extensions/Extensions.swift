//
//  Extensions.swift
//  NewsToDay
//
//  Created by Daniil Kulikovskiy on 10.05.2023.
//

import UIKit

extension UILabel {
    func setLineHeight(_ lineHeight: CGFloat) {
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - self.font.pointSize
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}

extension UIColor {
    static var blackDarker: UIColor { UIColor(named: "Black Darker")! }
    static var blackLight: UIColor { UIColor(named: "Black Light")! }
    static var blackLighter: UIColor { UIColor(named: "Black Lighter")!}
    static var blackPrimary: UIColor { UIColor(named: "Black Primary")!}
    static var greyDarker: UIColor { UIColor(named: "Grey Darker")!}
    static var greyLight: UIColor { UIColor(named: "Grey Light")!}
    static var greyLighter: UIColor { UIColor(named: "Grey Lighter")!}
    static var greyPrimary: UIColor { UIColor(named: "Grey Primary")!}
    static var purpleDarker: UIColor { UIColor(named: "Purple Darker")!}
    static var purpleLight: UIColor { UIColor(named: "Purple Light")!}
    static var purpleLighter: UIColor { UIColor(named: "Purple Lighter")!}
    static var purplePrimary: UIColor { UIColor(named: "Purple Primary")!}
}
