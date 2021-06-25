//
//  JSONEncapsulation.swift
//  
//
//  Created by lzh on 2021/6/25.
//

import Foundation

/// JSON编解码封装
struct JSONEncapsulation {}

    
// MARK: - JSONDecoder & JSONEncoder

extension JSONEncapsulation {
    
    /// 将JSON数据解码为模型实例
    /// - Parameters:
    ///   - type: 模型类型
    ///   - data: JSON数据
    /// - Returns: 模型实例
    static func decode<T>(_ type: T.Type, from data: Data?) -> T? where T : Decodable {
        guard let data = data else { return nil }
        
        let decoder = JSONDecoder()
        guard let model = try? decoder.decode(type, from: data) else { return nil }
        
        return model
    }

    /// 将模型实例编码为JSON数据
    /// - Parameter model: 模型实例
    /// - Returns: JSON数据
    static func encode<T>(_ model: T?) -> Data? where T : Encodable {
        guard let model = model else { return nil }
        
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(model) else { return nil }
        
        return data
    }
    
}


// MARK: - JSONSerialization

extension JSONEncapsulation {
    
    /// 将JSON数据解码为JSON对象
    /// - Parameter data: JSON数据
    /// - Returns: JSON对象
    static func jsonObject(with data: Data?) -> JSONObject? {
        guard let data = data else { return nil }
        
        guard let object = try? JSONSerialization.jsonObject(with: data) else { return nil }
        
        return object
    }
    
    /// 将JSON对象编码为JSON数据
    /// - Parameter object: JSON对象
    /// - Returns: JSON数据
    static func data(withJSONObject object: JSONObject?) -> Data? {
        guard let object = object else { return nil }
        
        guard let data = try? JSONSerialization.data(withJSONObject: object) else { return nil }
        
        return data
    }
    
}
