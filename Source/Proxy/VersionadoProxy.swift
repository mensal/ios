import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

protocol VersionadoResponse {
    associatedtype E : Versionado
    
    var id: UUID {get set}
    init(_ json: JSON)
    
    func preenche(_ persistido: E)
}

class VersionadoProxy<S: VersionadoResponse> {
    
    private let endpoint: String
    
    required init() {
        self.endpoint = ""
    }
    
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
