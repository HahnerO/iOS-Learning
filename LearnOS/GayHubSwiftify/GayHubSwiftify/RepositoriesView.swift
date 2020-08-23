//
//  RepositoriesView.swift
//  GayhubSwiftify
//
//  Created by 王籽涵 on 2020/8/20.
//  Copyright © 2020 hahn. All rights reserved.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct RepositoriesView: View {
    @ObservedObject var viewModel:RepositoriesViewModel = RepositoriesViewModel()

    var body: some View {
        List(0..<self.viewModel.repos.count) {idx in
            SingleRepositoryView(avatarUrlString: self.viewModel.repos[idx].owner.avatarUrl, fullName: self.viewModel.repos[idx].fullName)
        }
        .navigationBarTitle("Repositories")
        .onAppear{
            print("repos view appearing")
            self.viewModel.load()
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesView()
    }
}


// child view
struct SingleRepositoryView: View {
    var placeHolderImageName:String = "gayhub"
    var avatarUrlString:String
    var fullName:String = "Repository Name"

    var body: some View {
        HStack {
            WebImage(url: URL(string: avatarUrlString))
                .placeholder(Image(placeHolderImageName))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(.trailing, 10)

            Text(fullName)

            Spacer()
        }
    }
}
