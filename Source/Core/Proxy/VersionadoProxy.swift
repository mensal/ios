import Foundation
import CoreData
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON
import SwiftDate

class VersionadoRequest<E: Versionado>: ProxyRequest {
    var id: UUID?
    var atualizacaoRemotaEm: Date?

    var json: JSON?

    required init(_ entidade: E) {
        self.id = entidade.id
        self.atualizacaoRemotaEm = entidade.atualizacaoRemotaEm
    }
}

class VersionadoResponse<E: Versionado>: ProxyResponse {
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

class VersionadoProxy<E: Versionado, R: VersionadoRequest<E>, S: VersionadoResponse<E>>: Proxy {

    var path: String

    var autenticacaoDelegate: AutenticacaoDelegate?

    required init() {
        self.path = ""
    }

    init(_ path: String) {
        self.path = path
    }

    func obterTodos(apos: Date?, _ callback: @escaping ([S]) -> Void) {
        let headers = AppConfig.shared.authHeader
        let parameters = [
            "atualizado_apos": (apos ?? Date.distantPast).toISO(.withInternetDateTimeExtended),
            "mostrar_excluidos": "true"
        ]

        Alamofire.request(
            AppConfig.shared.apiBaseUrl.appendingPathComponent(path),
            method: .get,
            parameters: parameters,
            headers: headers).responseSwiftyJSON { response in

                if response.response?.statusCode == 401 {
                    self.autenticacaoDelegate?.naoAutenticado()
                }

                let resultado = response.result.value?.map { S($1) }
                callback(resultado ?? [S]())
        }
    }

    func excluir(_ entidade: E, _ callback: @escaping (S) -> Void) {
        let headers = AppConfig.shared.authHeader

        Alamofire.request(
            AppConfig.shared.apiBaseUrl.appendingPathComponent(path).appendingPathComponent(entidade.id!.uuidString),
            method: .delete,
            headers: headers).responseSwiftyJSON { response in

                if response.response?.statusCode == 401 {
                    self.autenticacaoDelegate?.naoAutenticado()
                }

                let resultado = S(response.result.value ?? JSON())
                callback(resultado)
        }
    }
}
