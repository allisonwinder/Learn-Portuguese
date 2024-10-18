//
//  Pie.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/17/24.
//

import SwiftUI

struct Pie: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise = true
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius: Double = min(rect.height, rect.width) / 6
        let startPoint = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians))
        
        var p = Path()
        
        p.move(to: center)
        p.addLine(to: startPoint)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        return p
    }
    
    
}

#Preview {
    Pie(startAngle: Angle(degrees: 360-90), endAngle: Angle(degrees: 105-90))
        .foregroundStyle(.orange)
        .opacity(0.4)
        .padding()
}
