import Foundation
import CoreData
import SwiftDate

class PagamentoManager<E: Pagamento, S: PagamentoResponse<E>, P: PagamentoProxy<E, S>>: SincronizadoManager<E, S, P> {

    // MARK: - Públicos

    func obter(_ mes: Mes, _ context: NSManagedObjectContext) -> [E] {
        return tabela(context)
            .filter {_ in NSPredicate(format: "data >= %@ and data <= %@ and excluidoEm = nil", mes.inicio! as CVarArg, mes.fim! as CVarArg)}
            .sort(using: sortDescriptors)
            .execute()
    }
}
