import Foundation
import CoreData

class VeiculoManager: VersionadoManager<Veiculo> {
    
    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "nome", ascending: true)])
    }
    
    // MARK: - Declarados
    
    func sincronizar() {
        VeiculoProxy().obterTodos { response in
            let context = persistentContainer.viewContext
            
            response.forEach {
                let persistido = self.obterOuNovo($0.id, context)
                persistido.nome = $0.nome
            }
            
            try? context.save()
        }
    }
}
