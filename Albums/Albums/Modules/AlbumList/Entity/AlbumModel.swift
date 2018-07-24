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
    var id : String = ""

    enum CodingKeys: String, CodingKey {
        case urlList = "urls"
        case user
        case id = "id"
    }
}

extension AlbumModel: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(String.self, forKey: .id)
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
            do {
                username = try values.decode(String.self, forKey: .name)
            } catch {
                print("name key not present in response")
            }
            do {
                bio = try values.decode(String.self, forKey: .bio)
            } catch {
                print("bio key not present in response")
            }
            do {
                location = try values.decode(String.self, forKey: .location)
            } catch {
                print("location key not present in response")
            }
        }catch{
            print("user key not present in response")
        }

        
       

    }
}

struct UrlList {
    var thumbUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        case thumb
    }
}

extension UrlList: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            thumbUrl = try values.decode(String.self, forKey: .thumb)
        } catch {
            
        }
    }
}

