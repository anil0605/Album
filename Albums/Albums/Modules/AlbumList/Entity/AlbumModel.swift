//
//  AlbumWireFrame.swift
//  YasMobileSDK
//
//  Created by Anil Kothari on 11/3/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//


import UIKit

struct AlbumModel {
    var color: String
    var id: String
    var urlList : UrlList
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case color
        case urlList = "urls"
    }
}


extension AlbumModel: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        color = try values.decode(String.self, forKey: .color)
        id = try values.decode(String.self, forKey: .id)
        urlList = try values.decode(UrlList.self, forKey: .urlList)
    }
}


struct UrlList {
    var rawUrl: String
    var fullUrl: String
    var regularUrl: String
    var smallUrl: String
    var thumbUrl: String
    
    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

extension UrlList: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rawUrl = try values.decode(String.self, forKey: .raw)
        fullUrl = try values.decode(String.self, forKey: .full)
        regularUrl = try values.decode(String.self, forKey: .regular)
        smallUrl = try values.decode(String.self, forKey: .small)
        thumbUrl = try values.decode(String.self, forKey: .thumb)
    }
}

