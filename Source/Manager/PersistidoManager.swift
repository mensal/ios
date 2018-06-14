import Foundation
import CoreData
import AlecrimCoreData

class PersistidoManager<T: NSManagedObject> {

    // MARK: - Propriedades
    
    let sortDescriptors: [NSSortDescriptor]
    
    // MARK: - Construtores
    
    init(_ sortDescriptors: [NSSortDescriptor]) {
        self.sortDescriptors = sortDescriptors
    }

    // MARK: - Públicos

    func novo(_ context: NSManagedObjectContext) -> T {
        return tabela(context).create()
    }

    func tabela(_ context: NSManagedObjectContext) -> Table<T> {
        return Table<T>(context: context)
    }

    func obterTodos(_ context: NSManagedObjectContext) -> [T] {
        return tabela(context).sort(using: sortDescriptors).execute()
    }
}
