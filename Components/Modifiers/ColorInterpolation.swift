//
//  ColorInterpolation.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/22/24.
//

import SwiftUI
import UIKit


func rgbFromColor(_ color: Color) -> Array<Double> {
    let uiColor = UIColor(color)
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    let redValue = Double(red)
    let greenValue = Double(green)
    let blueValue = Double(blue)

    return [redValue, greenValue, blueValue]
}

func harshColorFromValue(_ value: Double) -> Color {
    return colorFromValue(value, leftColor: Theme.deep_blue.mainColor, rightColor: Theme.deep_red.mainColor)
}

func lightColorFromValue(_ value: Double) -> Color {
    return colorFromValue(value, leftColor: Theme.blue_accent.mainColor, rightColor: Theme.red_accent.mainColor)
}

func colorFromValue(_ value: Double, leftColor: Color, rightColor: Color, midColor: Color = Theme.very_light_gray.mainColor) -> Color {
    let blueRGB = rgbFromColor(leftColor)
    let redRGB = rgbFromColor(rightColor)
    
    let rgb: [Double]
    if value == 0.0 {
        return midColor
    } else if value <= 0.0 {
        let ratio = (value + 10.0) / 10.0
        rgb = interpolateColor(rgbFromColor(Theme.light_blue.mainColor), and: blueRGB, with: ratio)
    } else {
        let ratio = value / 10.0
        rgb = interpolateColor(rgbFromColor(Theme.light_red.mainColor), and: redRGB, with: ratio)
    }
    
    return Color(red: rgb[0], green: rgb[1], blue: rgb[2])
}

func interpolateColor(_ startColor: [Double], and endColor: [Double], with ratio: Double) -> [Double] {
    return [
        startColor[0] + (endColor[0] - startColor[0]) * ratio,
        startColor[1] + (endColor[1] - startColor[1]) * ratio,
        startColor[2] + (endColor[2] - startColor[2]) * ratio
    ]
}
