//
//  JSONModel+Array.swift
//  
//
//  Created by lzh on 2022/7/27.
//

import Foundation

extension Array: JSONCompatible {}

extension Array: JSONModel, CustomMultipleKeysCoding where Element: Codable & CustomMultipleKeysCoding {
    public static var customMultipleKeysCodingDict: [String : String] {
        Element.customMultipleKeysCodingDict
    }
    
    /// 使用数组构造[JSON]模型数组
    /// - Parameter array: 数组
    public init?(json array: [Any]?) {
        guard let array = array else { return nil }
        let data = try? JSONSerialization.data(withJSONObject: array)
        self.init(json: data)
    }
}

extension JSON where Base: MutableCollection & JSONModel {
    /// [JSON]数组
    public var array: [Any]? {
        guard let data = data else { return nil }
        guard let object = try? JSONSerialization.jsonObject(with: data) else { return nil }
        return object as? [Any]
    }
}
