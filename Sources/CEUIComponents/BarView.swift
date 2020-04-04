//
//  BarView.swift
//  CEUIComponents
//
//  Created by Çağatay Emekci on 5.04.2020.
//
import SwiftUI

public class BarObject: ObservableObject {
    @Published public var barWith: CGFloat = 0
    @Published public var backColor: UIColor = .red
    @Published public var barColor: UIColor = .blue
    public init() {}
}

public struct BarView: View  {
    @ObservedObject var bar: BarObject
    public init(bar: BarObject){
        self.bar = bar
    }
    public var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .leading) {
                HStack {
                    Rectangle()
                        .fill(Color(self.bar.backColor))
                        .frame(width: geometry.size.width, height: 10.0)
                        .cornerRadius(3)
                }
                HStack {
                    Rectangle()
                        .fill(Color(self.bar.barColor))
                        .frame(width: geometry.size.width * (self.bar.barWith / 100), height: 10.0)
                        .cornerRadius(3)
                }.animation(Animation.easeOut(duration: 1).delay(1))
            }

        }
    }
}
