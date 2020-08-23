//
//  singleButtonView.swift
//  GayhubSwiftify
//
//  Created by 王籽涵 on 2020/8/20.
//  Copyright © 2020 hahn. All rights reserved.
//

import SwiftUI

struct SingleButtonView: View {
    var cellName:String = "Cell Name"
    var cellImageName:String = "gayhub"


    var body: some View {
        HStack {
            Image(cellImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
                .padding(.horizontal, 10)


            Text(cellName)
                .foregroundColor(Color.black)
                .font(.system(size: 20, weight: .regular))

            Spacer()

            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
                .foregroundColor(Color.gray)
                .padding(.horizontal, 20)
        }
        .frame(height: 50)
        .background(Color(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0.1491598887)))
    }
}

struct SingleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SingleButtonView()
    }
}
