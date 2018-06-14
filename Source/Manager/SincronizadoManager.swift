import Foundation
import CoreData
import AlecrimCoreData

class SincronizadoManager<E: Versionado, S: VersionadoResponse<E>, P: VersionadoProxy<E, S>>: VersionadoManager<E> {
    
    // MARK: - Públicos

    func sincronizar() {
        P().obterTodos { resultado in
            let context = persistentContainer.viewContext
            resultado.forEach { $0.preenche(self.obterOuNovo($0.id, context)) }
            
            try? context.save()
        }
    }
}
