//
//  JSONTypeCast.swift
//  
//
//  Created by lzh on 2021/6/25.
//

/// JSON类型转换
struct JSONTypeCast {}


// MARK: - JSON数据与JSON字符串互转

extension JSONTypeCast {
    
    /// 将JSON字符串转换为JSON数据
    /// - Parameter string: JSON字符串
    /// - Returns: JSON数据
    static func toData(from string: String?) -> JSONData? {
        guard let string = string else { return nil }
        
        return string.data(using: .utf8)
    }

    /// 将JSON数据转换为JSON字符串
    /// - Parameter data: JSON数据
    /// - Returns: JSON字符串
    static func toString(from data: JSONData?) -> String? {
        guard let data = data else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
    
}


// MARK: - JSON对象与字典互转

extension JSONTypeCast {
    
    /// 将字典转换为JSON对象
    /// - Parameter dict: 字典
    /// - Returns: JSON对象
    static func toObject(from dict: JSONDictionary?) -> JSONObject? {
        return dict
    }
    
    /// 将JSON对象转换为字典
    /// - Parameter object: JSON对象
    /// - Returns: 字典
    static func toDict(from object: JSONObject?) -> JSONDictionary? {
        return object as? JSONDictionary
    }
    
}


/*
 Data: 数据
 Model: 模型
 Object 对象
 decode(): JSONDecoder.decode()
 encode(): JSONEncoder.encode()
 jsonObject(): JSONSerialization.jsonObject()
 data(): JSONSerialization.data()
 
 JSON数据与模型互转:
 
     Data   ---   decode()   --->  Model
     Model  ---   encode()   --->  Data
 
 JSON数据与JSON对象互转:
 
     Data   --- jsonObject() --->  Object
     Object --- data()       --->  Data
 
 JSON对象与模型互转:
 
     Object --> data() --> Data --> docode() --> Model
     Model  --> encode() --> Data --> jsonObject() --> Object
 
 事实上:
 
 JSONDecoder.decode() = JSONSerialization.jsonObject() -> 对象转模型
 JSONEncoder.encode() = 模型转对象 -> JSONSerialization.data()
 
 则"JSON对象与模型互转"可以等效为:
 
 Object --> data() --> Data --> jsonObject() --> Object --> 对象转模型 --> Model
 Model --> 模型转对象 --> Object --> data() --> Data --> jsonObject() --> Object
 
 发现产生了不必要的JSON数据与JSON对象互转，多了一个中间商。
 
 解决方法:
 
 参考官方Codable源码实现一个对象与模型直接互转
 
 更多思考:
 
 SwiftyJSON实际上封装了JSONSerialization，实现了由JSON数据/字符串到JSON对象/字典的转换，只不过将对象/字典封装在JSON结构体内部，
 并提供了一些subscript下标访问，还提供了名为int,string等的计算属性用于转换为确定类型。
 
 ObjectMapper也是对JSONSerialization和JSONDecoder/JSONEncoder的封装，个人认为封装的有些糟糕思路有些混乱提供的接口更是很古怪，
 明明封装了JSONDecoder/JSONEncoder竟然还需要手写对象/字典到模型的映射。
 
 JSON数据/字符串到JSON对象/字典的转换通过JSONSerialization已经完成，想要将对象/字典映射到模型，如果没有JSONDecoder/JSONEncoder
 不可避免的要手写对象/字典到模型的映射。幸好，有JSONDecoder/JSONEncoder。继承了Decodable/Encodable协议的类型，编译器会自动生成
 相应的对象/字典到模型的映射。swiftc filename -emit-sil > temp.sil命令可以看到，果真在Swift Intermediate Language
 中自动生成了相应的中间代码。
 
 脱离开JSON，字典和模型的互相转换，可以继承Codable协议，并参照官方代码实现字典和模型的相互转换，不必再手写字典和模型的映射。
 
 */


// MARK: - JSON数据与模型互转

extension JSONTypeCast {
    
    /// 将JSON数据转换为模型实例
    /// - Parameters:
    ///   - type: 模型类型
    ///   - data: JSON数据
    /// - Returns: 模型实例
    static func toModel<T>(_ type: T.Type, from data: JSONData?) -> T? where T : Decodable {
        
        let model = JSONEncapsulation.decode(type, from: data)
        return model
    }
    
    /// 将模型实例转换为JSON数据
    /// - Parameter model: 模型实例
    /// - Returns: JSON数据
    static func toData<T>(from model: T?) -> JSONData? where T : Encodable {
        
        let data = JSONEncapsulation.encode(model)
        return data
    }
    
}


// MARK: - JSON数据与JSON对象互转

extension JSONTypeCast {
    
    /// 将JSON数据转换为JSON对象
    /// - Parameter data: JSON数据
    /// - Returns: JSON对象
    static func toObject(from data: JSONData?) -> JSONObject? {
        
        let object = JSONEncapsulation.jsonObject(with: data)
        return object
    }
    
    /// 将JSON对象转换为JSON数据
    /// - Parameter object: JSON对象
    /// - Returns: JSON数据
    static func toData(from object: JSONObject?) -> JSONData? {
        
        let data = JSONEncapsulation.data(withJSONObject: object)
        return data
    }
    
}


// MARK: - JSON对象与模型互转

extension JSONTypeCast {
    
    /// 将JSON对象转换为模型实例
    /// - Parameters:
    ///   - type: 模型类型
    ///   - object: JSON对象
    /// - Returns: 模型实例
    static func toModel<T>(_ type: T.Type, from object: JSONObject?) -> T? where T : Decodable {
        
        let data = toData(from: object)
        
        let model = toModel(type, from: data)
        
        return model
    }
    
    /// 将模型实例转换为JSON对象
    /// - Parameter model: 模型实例
    /// - Returns: JSON对象
    static func toObject<T>(from model: T?) -> JSONObject? where T : Encodable {
        
        let data = toData(from: model)
        
        let object = toObject(from: data)
        
        return object
    }
    
}
