import Foundation
import CoreData
import AlecrimCoreData

class VersionadoManager<E: Versionado>: PersistidoManager<E> {

    // MARK: - Públicos

    func obterOuNovo(_ id: UUID, _ context: NSManagedObjectContext) -> E {
        var resultado = obter(id, context)

        if resultado == nil {
            resultado = novo(context)
            resultado!.id = id
        }

        return resultado!
    }

    func obter(_ id: UUID, _ context: NSManagedObjectContext) -> E? {
        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    }
}
