# JSON

JSON parser.

struct Hello {
    var world: String
}


let jsonString = """
{
    "world": "你好，世界！"
}
"""

let jsonData = jsonString.data(using: .utf8)!



extension Hello: JSONModel {}


