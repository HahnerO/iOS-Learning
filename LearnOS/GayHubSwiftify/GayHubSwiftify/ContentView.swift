//
//  ContentView.swift
//  GayhubSwiftify
//
//  Created by 王籽涵 on 2020/8/19.
//  Copyright © 2020 hahn. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("My Work")
                            .bold()
                            .font(.system(size: 20))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)

                    VStack(spacing: 0) {
                        SingleButtonView(cellName: "Issues", cellImageName: "issues")

                        Divider()
                            .padding(.leading, 60)

                        SingleButtonView(cellName: "Branch", cellImageName: "branch")

                        Divider()
                        .padding(.leading, 60)

                        NavigationLink(destination: RepositoriesView()) {
                            SingleButtonView(cellName: "Repositories", cellImageName: "repositories")
                        }
                        .buttonStyle(PlainButtonStyle())

                        Divider()
                        .padding(.leading, 60)

                        SingleButtonView(cellName: "Group", cellImageName: "group")
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                    .cornerRadius(10)
                        .modifier(ShadowModifier())

                .padding(5)

                }
                .padding(.vertical, 10)
            }
            .navigationBarTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
