//
//  PlayGroundView.swift
//  GayhubSwiftify
//
//  Created by 王籽涵 on 2020/8/21.
//  Copyright © 2020 hahn. All rights reserved.
//

import SwiftUI

struct PlayGroundView: View {
    @State var scale = 1;
    @State var move = 0
    var body: some View {
//        ZStack {
//            Text("hello")
//
//            Color.yellow
//        }

        Button(action: {
//            self.scale += 1
            self.move += 1
        }) {
            Rectangle()
                .frame(width: 50 * CGFloat(scale), height: 50 * CGFloat(scale), alignment: .center)
                .foregroundColor(Color.blue)
                .cornerRadius(10)
        }
        .offset(x:30 * CGFloat(move))
        .animation(.spring(response:0.5, dampingFraction:0.825, blendDuration: 0))
//
    }
}

struct PlayGroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlayGroundView()
    }
}
