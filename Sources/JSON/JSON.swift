//
//  JSON.swift
//  
//
//  Created by lzh on 2021/8/16.
//

/// JSON
public struct JSON<Base> {
    /// JSON基类
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

/// 可进行JSON操作的协议
public protocol JSONCompatible {
    associatedtype Base
    
    var json: JSON<Base> { get }
}

extension JSONCompatible {
    /// JSON扩展
    public var json: JSON<Self> {
        JSON(self)
    }
}
