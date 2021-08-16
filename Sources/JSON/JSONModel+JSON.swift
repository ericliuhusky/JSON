//
//  JSONModel+JSON.swift
//  
//
//  Created by lzh on 2021/8/16.
//

import Foundation

extension JSON where Base: JSONModel {
    /// JSON数据
    public var data: Data? {
        guard let data = try? JSONEncoder().encode(base) else { return nil }
        return data
    }
    
    /// JSON字符串
    public var string: String? {
        guard let data = data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// JSON字典
    public var dict: [String: Any]? {
        guard let data = data else { return nil }
        guard let object = try? JSONSerialization.jsonObject(with: data) else { return nil }
        return object as? [String: Any]
    }
}
