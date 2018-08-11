import Foundation
import CoreData

class PagamentoFixaManager: PagamentoManager<PagamentoFixa, PagamentoFixaRequest, PagamentoFixaResponse, PagamentoFixaProxy> {

    // MARK: - Construtores

    init() {
        super.init([NSSortDescriptor(key: "data", ascending: true), NSSortDescriptor(key: "fixa.nome", ascending: true)])
    }
}
