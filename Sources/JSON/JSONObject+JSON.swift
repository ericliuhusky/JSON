//
//  JSONObject+JSON.swift
//  
//
//  Created by lzh on 2021/8/16.
//

import Foundation

extension JSONObject: JSONCompatible {}


extension JSON where Base == JSONObject {
    /// JSON数据
    public var data: Data? {
        let data = try? JSONSerialization.data(withJSONObject: base.object as Any)
        return data
    }
    
    /// JSON字符串
    public var string: String? {
        guard let data = data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// JSON字典
    public var dict: [String: Any]? {
        base.object as? [String: Any]
    }
}
