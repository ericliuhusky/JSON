//
//  JSON.swift
//  
//
//  Created by lzh on 2021/6/25.
//

/// JSON对象结构体
@dynamicMemberLookup
struct JSON {
    
    /// 使用JSON对象构造JSON
    /// - Parameter object: JSON对象
    init(_ object: JSONObject?) {
        self.object = object
    }
    
    /// JSON对象
    var object: JSONObject?
    
}


// MARK: - JSON数据与JSON字符串互转

extension JSON {
    
    /// 使用JSON字符串构造JSON
    /// - Parameter string: JSON字符串
    init(string: String?) {
        let data = JSONTypeCast.toData(from: string)
        self.init(data: data)
    }
    
    /// JSON的JSON字符串
    var string: String? {
        let string = JSONTypeCast.toString(from: data)
        return string
    }
    
}


// MARK: - JSON对象与字典互转

extension JSON {
    
    /// 使用字典构造JSON
    /// - Parameter dict: 字典
    init(dict: JSONDictionary?) {
        let object = JSONTypeCast.toObject(from: dict)
        self.init(object)
    }
    
    /// JSON的字典
    var dict: JSONDictionary? {
        let dict = JSONTypeCast.toDict(from: object)
        return dict
    }
    
}


// MARK: - JSON数据与JSON对象互转

extension JSON {
    
    /// 使用JSON数据构造JSON
    /// - Parameter data: JSON数据
    init(data: JSONData?) {
        let object = JSONTypeCast.toObject(from: data)
        self.init(object)
    }
    
    /// JSON的JSON数据
    var data: JSONData? {
        let data = JSONTypeCast.toData(from: object)
        return data
    }
    
}


// MARK: - JSON对象与模型互转

extension JSON {
    
    /// 使用模型实例构造JSON
    /// - Parameter model: 模型实例
    init<T>(model: T?) where T : Encodable {
        let object = JSONTypeCast.toObject(from: model)
        self.init(object)
    }
    
    /// JSON的模型实例
    /// - Parameter type: 模型类型
    /// - Returns: 模型实例
    func model<T>(_ type: T.Type) -> T? where T : Decodable {
        let model = JSONTypeCast.toModel(T.self, from: object)
        return model
    }
    
}


// MARK: - 下标访问

extension JSON {
    
    // 为JSON提供关键字下标访问
    subscript(key: String) -> JSON? {
        guard let dict = self.dict else { return nil }
        let object = dict[key]
        return JSON(object)
    }
    
    // 为JSON提供动态成员查询
    subscript(dynamicMember key: String) -> JSON? {
        self[key]
    }
    
}


// MARK: - 类型转换

extension JSON {
    
    /// 作为字符串
    var asString: String? {
        object as? String
    }
    
}
