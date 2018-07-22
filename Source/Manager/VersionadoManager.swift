import Foundation
import CoreData
import AlecrimCoreData

enum ModoExclusao {
    case fisica
    case logica
}

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
        return tabela(context).first { _ in NSPredicate(format: "id = %@", argumentArray: [id]) }
    }

    func obterTodos(_ context: NSManagedObjectContext) -> [E] {
        return tabela(context)
            .filter {_ in NSPredicate(format: "excluidoEm = nil")}
            .sort(using: sortDescriptors)
            .execute()
    }

    func obterExcluidos(_ context: NSManagedObjectContext) -> [E] {
        return tabela(context)
            .filter {_ in NSPredicate(format: "excluidoEm != nil")}
            .sort(using: sortDescriptors)
            .execute()
    }

    func obterUltimaAtualizacao(_ context: NSManagedObjectContext) -> Date? {
        var query = tabela(context).sort(using: [NSSortDescriptor(key: "atualizacaoRemotaEm", ascending: false)])
        query.limit = 1

        return query.execute().first?.atualizacaoRemotaEm
    }

    func excluir(_ entidade: E, modo: ModoExclusao, _ context: NSManagedObjectContext) {
        if modo == .fisica {
            tabela(context).delete(entidade)
        } else {
            entidade.excluidoEm = Date()
        }
    }
}
