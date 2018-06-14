import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

class VersionadoResponse<E: Versionado> {
    var id: UUID
    
    required init(_ json: JSON) {
        self.id = UUID(uuidString: json["id"].string!)!
    }
    
    func preenche(_ persistido: E) {
        persistido.id = self.id
    }
}

class VersionadoProxy<E:  Versionado, S: VersionadoResponse<E>> {
    
    private let endpoint: String!
    
    required init() {
        self.endpoint = nil
    }
    
    init(_ endpoint: String) {
        self.endpoint = endpoint
    }

    func obterTodos(_ callback: @escaping ([S]) -> ()) {
        let headers = AppConfig.shared.authHeader
//        let parameters = [
//            "apos" : Date()
//        ]
        
        Alamofire.request(
            AppConfig.shared.apiBaseUrl + endpoint,
            method: .get,
//            parameters: parameters,
            headers: headers).responseSwiftyJSON{ response in
                let resultado = response.result.value?.map { S($1) }
                callback(resultado ?? [S]())
        }
    }
}
