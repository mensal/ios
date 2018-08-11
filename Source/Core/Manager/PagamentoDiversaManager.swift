import Foundation
import CoreData

class PagamentoDiversaManager: PagamentoManager<PagamentoDiversa, PagamentoDiversaRequest, PagamentoDiversaResponse, PagamentoDiversaProxy> {

    // MARK: - Construtores

    init() {
        super.init([NSSortDescriptor(key: "data", ascending: true), NSSortDescriptor(key: "diversa.nome", ascending: true)])
    }
}
