//
//  RepositoryModel.swift
//  GayhubSwiftify
//
//  Created by 王籽涵 on 2020/8/20.
//  Copyright © 2020 hahn. All rights reserved.
//

import SwiftUI
import Combine

struct Repository: Codable, Identifiable {
    public var id: Int
    public var fullName: String
    public var owner: Owner

    enum CodingKeys: String, CodingKey{
        case fullName = "full_name"
        case owner
        case id
    }
}

struct Owner: Codable{
    public var avatarUrl: String

    enum CodingKeys: String, CodingKey{
        case avatarUrl = "avatar_url"
    }
}
