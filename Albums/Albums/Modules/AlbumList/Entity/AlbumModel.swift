//
//  AlbumWireFrame.swift
//  YasMobileSDK
//
//  Created by Anil Kothari on 11/3/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//


import UIKit

struct AlbumModel {
    var urlList : UrlList?
    var user : User?

    enum CodingKeys: String, CodingKey {
        case urlList = "urls"
        case user
    }
}

extension AlbumModel: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            urlList = try values.decode(UrlList.self, forKey: .urlList)
            user = try values.decode(User.self, forKey: .user)
        } catch {
        }
    }
}

struct User {
    var username: String?
    var bio: String?
    var location : String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case bio
        case location
    }
}


extension User: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            username = try values.decode(String.self, forKey: .name)
            bio = try values.decode(String.self, forKey: .bio)
            location = try values.decode(String.self, forKey: .location)
        } catch {
        }
    }
}

struct UrlList {
    var rawUrl: String = ""
    var fullUrl: String = ""
    var regularUrl: String = ""
    var smallUrl: String = ""
    var thumbUrl: String = ""
    
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
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            rawUrl = try values.decode(String.self, forKey: .raw)
            fullUrl = try values.decode(String.self, forKey: .full)
            regularUrl = try values.decode(String.self, forKey: .regular)
            smallUrl = try values.decode(String.self, forKey: .small)
            thumbUrl = try values.decode(String.self, forKey: .thumb)
        } catch {
            
        }
    }
}

