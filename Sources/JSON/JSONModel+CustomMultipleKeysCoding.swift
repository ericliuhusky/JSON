//
//  JSONModel+CustomMultipleKeysCoding.swift
//  
//
//  Created by lzh on 2022/4/18.
//

import Foundation

/// 自定义多关键字编码协议
public protocol CustomMultipleKeysCoding {
    
    /// 自定义多关键字编码映射字典
    static var customMultipleKeysCodingDict: [String: String] { get }
    
    /// 自定义多关键字编码解码策略
    static var customMultipleKeysDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
}

extension CustomMultipleKeysCoding {
    public static var customMultipleKeysCodingDict: [String: String] {
        [:]
    }
    
    public static var customMultipleKeysDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        .custom { codingPath in
            CustomMultipleKeysCodingKey(stringValue: codingPath.last!.stringValue, codingDict: customMultipleKeysCodingDict)
        }
    }
}

fileprivate struct CustomMultipleKeysCodingKey: CodingKey {
    var intValue: Int?
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }

    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init(stringValue: String, codingDict: [String: String]) {
        self.stringValue = codingDict[stringValue] ?? stringValue
    }
}
