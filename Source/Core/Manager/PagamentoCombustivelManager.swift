import Foundation
import CoreData

class PagamentoCombustivelManager: PagamentoManager<PagamentoCombustivel, PagamentoCombustivelRequest, PagamentoCombustivelResponse, PagamentoCombustivelProxy> {

    // MARK: - Construtores

    init() {
        super.init([NSSortDescriptor(key: "data", ascending: true), NSSortDescriptor(key: "veiculo.nome", ascending: true)])
    }
}
