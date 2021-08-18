    import XCTest
    @testable import JSON
    
    struct Hello: JSONModel {
        var world: String
    }
    
    let world = "你好"
    
    let jsonStr = """
        { "world": "\(world)" }
        """
    let jsonData = jsonStr.data(using: .utf8)!
    let jsonDict = [
        "world": world
    ]
    
    let noneSpaceStr = jsonStr.replacingOccurrences(of: " ", with: "")
    let noneSpaceData = noneSpaceStr.data(using: .utf8)!
    
    final class JSONTests: XCTestCase {
        func testModel() {
            XCTAssertEqual(Hello(json: jsonStr)?.world, world)
            XCTAssertEqual(Hello(json: jsonData)?.world, world)
            XCTAssertEqual(Hello(json: jsonDict)?.world, world)
            
            XCTAssertEqual(Hello(json: jsonStr)?.json.string, noneSpaceStr)
            XCTAssertEqual(Hello(json: jsonStr)?.json.data, noneSpaceData)
            XCTAssertEqual(Hello(json: jsonStr)?.json.dict as? [String: String], jsonDict)
        }
        
        func testObject() {
            XCTAssertEqual(JSONObject(string: jsonStr).world?.string, world)
            XCTAssertEqual(JSONObject(data: jsonData).world?.string, world)
            XCTAssertEqual(JSONObject(dict: jsonDict).world?.string, world)
            
            XCTAssertEqual(JSONObject(string: jsonStr).json.string, noneSpaceStr)
            XCTAssertEqual(JSONObject(string: jsonStr).json.data, noneSpaceData)
            XCTAssertEqual(JSONObject(string: jsonStr).json.dict as? [String: String], jsonDict)
        }
    }
