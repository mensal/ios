import Foundation
import CoreData

class FixaManager: VersionadoManager<Fixa> {
    
    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "vencimento", ascending: true)])
    }

    // MARK: - Declarados
    
    func obterPagamentos(_ mes: Mes, _ context: NSManagedObjectContext) -> [Pagamento] {
        return [Pagamento]()
    }

    func sincronizar() {
        FixaProxy().obterTodos { response in
            let context = persistentContainer.viewContext
            
            response.forEach {
                let persistido = self.obterOuNovo($0.id, context)
                persistido.nome = $0.nome
                persistido.vencimento = Int16($0.vencimento)
            }
            
            try? context.save()
        }
    }
}
