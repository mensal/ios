import Foundation
import CoreData
import AlecrimCoreData

class VeiculoManager {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    private static func tabela(_ context: NSManagedObjectContext) -> Table<Veiculo> {
        return Table<Veiculo>(context: context)
    }
    
    static func obterOuNovo(_ id: UUID, _ context: NSManagedObjectContext) -> Veiculo {
        let resultado = obter(id, context)
        return resultado != nil ? resultado! : novo(context)
    }
    
    static func obter(_ id: UUID, _ context: NSManagedObjectContext) -> Veiculo? {
        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    }
    
    static func novo(_ context: NSManagedObjectContext) -> Veiculo {
        return tabela(context).create()
    }
    
    static func sincronizar(_ context: NSManagedObjectContext) {
        VeiculoProxy.obterTodos { response in
            response.forEach { VeiculoResponse in
                let persistido = obterOuNovo(VeiculoResponse.id ?? UUID(), context)
                persistido.nome = VeiculoResponse.nome
            }
        }
    }
}
