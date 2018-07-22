import Foundation
import CoreData
import AlecrimCoreData

class PersistidoManager<E: NSManagedObject> {

    // MARK: - Propriedades

    let sortDescriptors: [NSSortDescriptor]

    // MARK: - Construtores

    init(_ sortDescriptors: [NSSortDescriptor]) {
        self.sortDescriptors = sortDescriptors
    }

    // MARK: - Públicos

    func novo(_ context: NSManagedObjectContext) -> E {
        return tabela(context).create()
    }

    func tabela(_ context: NSManagedObjectContext) -> Table<E> {
        return Table<E>(context: context)
    }
}
