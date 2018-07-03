import Foundation
import CoreData
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

class VersionadoResponse<E: Versionado> {
    var id: UUID
    var atualizacaoRemotaEm: Date?
    var excluidoEm: Date?

    required init(_ json: JSON) {
        id = json["id"].uuid!
        atualizacaoRemotaEm = json["atualizado_em"].date
        excluidoEm = json["excluido_em"].date
    }

    func preenche(_ persistido: E, _ context: NSManagedObjectContext) {
        persistido.id = id
        persistido.atualizacaoRemotaEm = atualizacaoRemotaEm
        persistido.excluidoEm = excluidoEm
    }
}

class VersionadoProxy<E: Versionado, S: VersionadoResponse<E>> {

    private let path: String!

    required init() {
        self.path = nil
    }

    init(_ path: String) {
        self.path = path
    }

    func obterTodos(apos: Date?, _ callback: @escaping ([S]) -> Void) {
        let headers = AppConfig.shared.authHeader
//        let parameters = [
//            "atualizado_apos" : Date()
//        ]
        
        Alamofire.request(
            AppConfig.shared.apiBaseUrl.appendingPathComponent(path),
            method: .get,
//            parameters: parameters,
            headers: headers).responseSwiftyJSON { response in
                let resultado = response.result.value?.map { S($1) }
                callback(resultado ?? [S]())
        }
    }
}
