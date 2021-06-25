//
//  JSONModel.swift
//  
//
//  Created by lzh on 2021/6/25.
//

/// JSON模型协议
protocol JSONModel: Codable {}


extension JSONModel {
    
    /// JSON模型的JSON
    var json: JSON? {
        JSON(model: self)
    }
    
}


// MARK: - JSON数据与JSON字符串互转

extension JSONModel {
    
    /// 使用JSON字符串构造模型实例
    /// - Parameter string: JSON字符串
    init?(json string: String?) {
        let data = JSONTypeCast.toData(from: string)
        self.init(json: data)
    }

    /// 模型实例的JSON字符串
    var string: String? {
        let string = JSONTypeCast.toString(from: data)
        return string
    }

}


// MARK: - JSON对象与字典互转

extension JSONModel {
    
    /// 使用字典构造模型实例
    /// - Parameter dict: 字典
    init?(json dict: JSONDictionary?) {
        let object = JSONTypeCast.toObject(from: dict)
        self.init(json: object)
    }
    
    /// 模型实例的字典
    var dict: JSONDictionary? {
        let dict = JSONTypeCast.toDict(from: object)
        return dict
    }
    
}


// MARK: - JSON数据与模型互转

extension JSONModel {
    
    /// 使用JSON数据构造模型实例
    /// - Parameter data: JSON数据
    init?(json data: JSONData?) {
        guard let model = JSONTypeCast.toModel(Self.self, from: data) else { return nil }
        self = model
    }
    
    /// 模型实例的JSON数据
    var data: JSONData? {
        let data = JSONTypeCast.toData(from: self)
        return data
    }
    
}


// MARK: - JSON对象与模型互转

extension JSONModel {
    
    /// 使用JSON对象构造模型实例
    /// - Parameter object: JSON对象
    init?(json object: JSONObject?) {
        guard let model = JSONTypeCast.toModel(Self.self, from: object) else { return nil }
        self = model
    }
    
    /// 模型实例的JSON对象
    var object: JSONObject? {
        let object = JSONTypeCast.toObject(from: self)
        return object
    }
    
}
