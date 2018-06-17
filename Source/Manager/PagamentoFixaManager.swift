import Foundation
import CoreData

class PagamentoFixaManager: PagamentoManager<PagamentoFixa, PagamentoFixaResponse, PagamentoFixaProxy> {

    // MARK: - Construtores

    init() {
        super.init([NSSortDescriptor(key: "data", ascending: true), NSSortDescriptor(key: "fixa.nome", ascending: true)])
    }
}
