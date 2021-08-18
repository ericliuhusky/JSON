//
//  JSONObject.swift
//  
//
//  Created by lzh on 2021/8/16.
//

import Foundation

/// JSON对象
@dynamicMemberLookup
public struct JSONObject {
    /// 对象
    let object: Any?
    
    /// 使用对象构造JSON对象
    /// - Parameter object: 对象
    init(_ object: Any?) {
        self.object = object
    }
}

// MARK: - JSON对象的初始化函数

extension JSONObject {
    /// 使用JSON数据构造JSON对象
    /// - Parameter data: JSON数据
    public init(data: Data) {
        let object = try? JSONSerialization.jsonObject(with: data)
        self.init(object)
    }
    
    /// 使用JSON字符串构造JSON对象
    /// - Parameter string: JSON字符串
    public init(string: String) {
        guard let data = string.data(using: .utf8) else {
            self.init(nil)
            return
        }
        self.init(data: data)
    }
    
    /// 使用字典构造JSON对象
    /// - Parameter dict: 字典
    public init(dict: [String: Any]) {
        self.init(dict)
    }
}

// MARK: - 下标访问

extension JSONObject {
    // JSON对象的关键字下标访问
    public subscript(key: String) -> JSONObject? {
        guard let dict = self.json.dict else { return nil }
        let object = dict[key]
        return JSONObject(object)
    }
    
    // JSON对象的动态成员查询
    public subscript(dynamicMember key: String) -> JSONObject? {
        self[key]
    }
}

// MARK: - 类型转换

extension JSONObject {
    /// 作为字符串
    public var string: String? {
        object as? String
    }
    
    /// 作为整数
    public var int: Int? {
        object as? Int
    }
    
    /// 作为双精度浮点数
    public var double: Double? {
        object as? Double
    }
    
    /// 作为布尔值
    public var bool: Bool? {
        object as? Bool
    }
    
    /// 作为数组
    public var array: [JSONObject]? {
        guard let objectArray = object as? [Any] else { return nil }
        return objectArray.map { object in
            JSONObject(object)
        }
    }
    
    /// 作为字典
    public var dict: [String: JSONObject]? {
        guard let objectDict = object as? [String: Any] else { return nil }
        var dict = [String: JSONObject]()
        objectDict.forEach { pair in
            dict[pair.key] = JSONObject(pair.value)
        }
        return dict
    }
}
