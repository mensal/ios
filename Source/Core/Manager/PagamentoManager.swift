import Foundation
import CoreData
import SwiftDate

class PagamentoManager<E: Pagamento, Q: PagamentoRequest<E>, S: PagamentoResponse<E>, P: PagamentoProxy<E, Q, S>>: SincronizadoManager<E, Q, S, P> {

    // MARK: - Públicos

    func obter(_ mes: Mes, _ context: NSManagedObjectContext) -> [E] {
        return tabela(context)
            .filter {_ in NSPredicate(format: "data >= %@ and data <= %@ and excluidoEm = nil", argumentArray: [mes.inicio!, mes.fim!])}
            .sort(using: sortDescriptors)
            .execute()
    }
}
