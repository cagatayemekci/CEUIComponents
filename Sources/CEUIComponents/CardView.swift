//
//  CardView.swift
//  CEUIComponents
//
//  Created by Çağatay Emekci on 3.04.2020.
//

import SwiftUI

public class CardViewRowItem: Identifiable, ObservableObject {
    var name: String?
    var inAppPurchase: Bool?
    var itemId: Int?
    var explanation: String?
    var percentage: Int?
    var image: UIImage?
    public init(name: String? = nil, inAppPurchase: Bool? = false, itemId: Int? = nil, explanation: String? = nil, percentage: Int? = nil, image:UIImage? = nil) {
        self.name = name
        self.inAppPurchase = inAppPurchase
        self.itemId = itemId
        self.explanation = explanation
        self.percentage =  percentage
        self.image = image
    }
    
    var percentageValue: CGFloat {
           get {
               if percentage == nil || percentage == 0 {
                   return 0
               }
            return CGFloat(integerLiteral: (percentage ?? 1 )) / 100
           }
       }
}

public struct CardView: View {
    @ObservedObject var rowItem: CardViewRowItem
    public init(rowItem: CardViewRowItem){
        self.rowItem = rowItem
    }
    public var body: some View {
        VStack {
            HStack(spacing: 12.0) {
                ZStack {
                    Circle()
                        .trim(from: 0, to: rowItem.percentageValue)
                        .stroke(Color(.red),style: StrokeStyle(lineWidth: 10, lineCap: CGLineCap.round))
                        .frame(height: 80)
                        .rotationEffect(.degrees(-90)) // Start from top
                        .overlay(
                            Image(uiImage: rowItem.image!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                    )
                        .animation(Animation.linear(duration: 1).delay(1))
                }.frame(width: 80, height: 80)
                    .background(Color("background"))
                    .cornerRadius(40).padding(.leading, 8)
                VStack(alignment: .leading, spacing: 8) {
                    Text(rowItem.name ?? "")
                        .font(.headline)
                    
                    Text(rowItem.explanation ?? "")
                        .lineSpacing(4)
                        .font(.subheadline)
                    
                    Text(rowItem.percentage?.description ?? "")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                }.padding(.trailing, 8)
                Spacer()
            }.padding([.top,.bottom],8)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1).shadow(color: Color.black.opacity(0.2), radius: 2, x: 1, y: 1)
            )
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(rowItem: CardViewRowItem(name: "Test"))
    }
}
