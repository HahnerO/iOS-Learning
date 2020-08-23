//
//  RepositoriesViewModel.swift
//  GayhubSwiftify
//
//  Created by 王籽涵 on 2020/8/20.
//  Copyright © 2020 hahn. All rights reserved.
//

import Foundation
import SwiftUI

let url:String = "https://api.github.com/users/WhatTheNathan/repos?access_token="

class RepositoriesViewModel: ObservableObject {
    @Published var repos = [Repository]()

    init() { load() }

    typealias CompletionJSONClosure = (_ data:[Repository]) -> Void
    var completionJSONClosure:CompletionJSONClosure =  {_ in }

    func fetchData(with url: String,
                     doneClosure:@escaping CompletionJSONClosure
                    ) {
        self.completionJSONClosure = doneClosure

        URLSession.shared.dataTask(with: URL(string: url)!) {(data,response,error) in
            do {
                if let jsonData = data {
                    let decodedLists = try JSONDecoder().decode([Repository].self, from: jsonData)
                    self.completionJSONClosure(decodedLists)
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
        }
        .resume()
    }

    func load() -> Void {
        self.fetchData(with: url) { resultData in
            self.repos = resultData
        }
    }
}
