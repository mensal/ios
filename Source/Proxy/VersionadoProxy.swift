import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

protocol VersionadoResponse {
    var id: UUID {get set}
    init(_ json: JSON)
}

class VersionadoProxy<S: VersionadoResponse> {
    
    private let endpoint: String
    
    init(_ endpoint: String) {
        self.endpoint = endpoint
    }

    func obterTodos(_ callback: @escaping ([S]) -> ()) {
        let headers = AppConfig.shared.authHeader
        
        Alamofire.request(
            AppConfig.shared.apiBaseUrl + endpoint,
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                let resultado = response.result.value?.map { S($1) }
                callback(resultado ?? [S]())
        }
    }
}
