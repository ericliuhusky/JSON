//
//  JSONModel.swift
//  
//
//  Created by lzh on 2021/8/16.
//

import Foundation

/// JSON模型协议
public protocol JSONModel: Codable, JSONCompatible, CustomMultipleKeysCoding {}

// MARK: - JSON模型的初始化函数

extension JSONModel {
    /// 使用JSON数据构造JSON模型
    /// - Parameter data: JSON数据
    public init?(json data: Data?) {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = Self.customMultipleKeysDecodingStrategy
        guard let model = try? decoder.decode(Self.self, from: data) else { return nil }
        self = model
    }
    
    /// 使用JSON字符串构造JSON模型
    /// - Parameter string: JSON字符串
    public init?(json string: String?) {
        guard let string = string else { return nil }
        let data = string.data(using: .utf8)
        self.init(json: data)
    }
    
    /// 使用字典构造JSON模型
    /// - Parameter dict: 字典
    public init?(json dict: [String: Any]?) {
        guard let dict = dict else { return nil }
        let data = try? JSONSerialization.data(withJSONObject: dict)
        self.init(json: data)
    }
}
