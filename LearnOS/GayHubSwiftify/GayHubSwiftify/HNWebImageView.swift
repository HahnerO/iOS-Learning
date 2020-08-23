//
//  HNImageView.swift
//  GayhubSwiftify
//
//  Created by 王籽涵 on 2020/8/20.
//  Copyright © 2020 hahn. All rights reserved.
//

import SwiftUI

struct HNWebImageView : View {
    var placeholderImageName:String = "gayhub"
    var urlString:String
    @State private var remoteImage : UIImage? = nil

    var body: some View {
        Image(uiImage: self.remoteImage ?? UIImage(named: placeholderImageName)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear{
                self.fetchRemoteImage(urlString: self.urlString)
        }
    }

    func fetchRemoteImage(urlString:String)
    {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let image = UIImage(data: data!){
                DispatchQueue.main.async {
                    self.remoteImage = image
                }
            }
            else{
                print(error ?? "download image faild")
            }
        }.resume()
    }
}

struct HNWebImageView_Previews: PreviewProvider {
    static var previews: some View {
        HNWebImageView(urlString: "")
    }
}
