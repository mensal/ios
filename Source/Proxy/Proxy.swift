import Foundation
import SwiftyJSON

protocol ProxyRequest {
    
    var json: JSON? { get }
}

protocol ProxyResponse {
    
    init(_ json: JSON)
}

protocol Proxy {
    
    var path: String { get }
}
