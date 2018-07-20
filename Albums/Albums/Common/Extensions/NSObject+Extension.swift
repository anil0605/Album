//
//  NSObject + Extension.swift
//  Albums
//
//  Created by Anil Kothari on 11/7/17.
//  Copyright © 2017 Sapient. All rights reserved.
//

import Foundation

extension NSObject {
    public var className: String {
        return String(describing: type(of: self))
    }

    public class var className: String {
        return String(describing: self)
    }
}
