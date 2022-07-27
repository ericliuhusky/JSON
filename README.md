# JSON

## JSONModel

### 使用JSON构造模型 ( JSON -> Model )

```swift
struct A: JSONModel {
    var a: Int
}


let jsonStr = """
{
  "a": 1
}
"""
let a1 = A(json: jsonStr)

let jsonDict = [
    "a": 1
]
let a2 = A(json: jsonDict)

let jsonData = jsonStr.data(using: .utf8)
let a3 = A(json: jsonData)
```

### 由模型生成JSON ( Model -> JSON )

```swift
struct A: JSONModel {
    var a: Int
}


let jsonStr = A(a: 1).json.string
let jsonDict = A(a: 1).json.dict
let jsonData = A(a: 1).json.data
```

### 自定义多关键字解析 ( CustomMultipleKeysCoding )

```swift
struct A: JSONModel {
    static let customMultipleKeysCodingDict = [
        "A": "a",
        "b": "a"
    ]
    
    var a: Int
}


let a1 = A(json: ["A": 1])
let a2 = A(json: ["b": 1])
let a3 = A(json: ["a": 1])
```

### 使用JSON数组构造模型数组 ( \[JSON\] -> \[Model\] )

```swift
struct A: JSONModel {
    var a: Int
}


let jsonArray = [
    ["a": 1],
    ["a": 2],
    ["a": 3]
]

let modelArray = [A](json: jsonArray)
```

## JSONObject

### 使用JSON构造JSON对象 ( JSON -> JSONObject )

```swift
let jsonStr = """
{
  "a": 1
}
"""
let obj1 = JSONObject(string: jsonStr)

let jsonDict = [
    "a": 1
]
let obj2 = JSONObject(dict: jsonDict)

let jsonData = jsonStr.data(using: .utf8)!
let obj3 = JSONObject(data: jsonData)
```

### 由JSON对象生成JSON ( JSONObject -> JSON )

```swift
let jsonStr = JSONObject(dict: ["a": 1]).json.string
let jsonDict = JSONObject(dict: ["a": 1]).json.dict
let jsonData = JSONObject(dict: ["a": 1]).json.data
```

### 使用JSONObject进行类似JavaScript式的动态成员查找

```swift
let jsonDict: [String: Any] = [
    "a": 1,
    "b": "b",
    "c": 1.2,
    "d": true,
    "e": [1, 2, 3],
    "f": [
        "g": 1
    ]
]


let obj = JSONObject(dict: jsonDict)

let a = obj.a?.int // 1
let b = obj.b?.string // "b"
let c = obj.c?.double // 1.2
let d = obj.d?.bool // true
let e = obj.e?.array // [JSONObject(1), JSONObject(2), JSONObject(3)]
let f = obj.f?.dict // ["g": JSONObject(1)]
let e0 = e?[0].int // 1
let g = f?["g"]?.int // 1
```
