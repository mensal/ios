import Foundation
import SwiftyJSON
import CoreData

class PagamentoResponse<E: Pagamento>: VersionadoResponse<E> {
    var data: Date
    var tipo: IdResponse
    var valores: [RateioResponse]

    required init(_ json: JSON) {
        data = json["data"].date!
        tipo = IdResponse()
        tipo.id = json["tipo"]["id"].uuid
        valores = [RateioResponse]()

        super.init(json)

        json["valores"].array?.forEach { json in
            let rateio = RateioResponse()

            rateio.valor = json["valor"].double
            rateio.usuario = IdResponse()
            rateio.usuario.id = json["usuario"]["id"].uuid!

            valores.append(rateio)
        }
    }

    override func preenche(_ persistido: E, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)

        persistido.data = data

        valores.forEach { rateioResponse in
            var rateioPersistido = persistido.rateiosArray?.first(where: { $0.usuario?.id == rateioResponse.usuario.id })

            if rateioPersistido == nil {
                let usuario = UsuarioManager().obterOuNovo(rateioResponse.usuario.id, context)
                rateioPersistido = RateioManager().obterOuNovo(persistido, usuario, context)
            }

            rateioPersistido!.valor = rateioResponse.valor
        }
    }
}

class IdResponse {
    var id: UUID!
}

class RateioResponse {
    var valor: Double!
    var usuario: IdResponse!
}

class PagamentoProxy<E: Pagamento, S: PagamentoResponse<E>>: VersionadoProxy<E, S> {
}
