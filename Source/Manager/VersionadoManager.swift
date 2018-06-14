import Foundation
import CoreData
import AlecrimCoreData

class VersionadoManager<E: Versionado> {
    
    // MARK: - Propriedades
    
    private let sortDescriptors: [NSSortDescriptor]

    // MARK: - Construtores
    
    init(_ sortDescriptors: [NSSortDescriptor]) {
        self.sortDescriptors = sortDescriptors
    }

    // MARK: - Privados
    
    private func tabela(_ context: NSManagedObjectContext) -> Table<E> {
        return Table<E>(context: context)
    }
    
    private func novo(_ context: NSManagedObjectContext) -> E {
        return tabela(context).create()
    }
    
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
    
    func obterTodos(_ context: NSManagedObjectContext) -> [E] {
        return tabela(context).sort(using: sortDescriptors).execute()
    }
}
