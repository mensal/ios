import Foundation
import CoreData

class RateioManager: PersistidoManager<Rateio> {

    // MARK: - Construtores

    init() {
        super.init([NSSortDescriptor(key: "usuario.nome", ascending: true)])
    }

    // MARK: - Públicos

    func obterOuNovo(_ pagamento: Pagamento, _ usuario: Usuario, _ context: NSManagedObjectContext) -> Rateio {
        var resultado = obter(pagamento, usuario, context)

        if resultado == nil {
            resultado = novo(context)
            resultado!.pagamento = pagamento
            resultado!.usuario = usuario
        }

        return resultado!
    }

    func obter(_ pagamento: Pagamento, _ usuario: Usuario, _ context: NSManagedObjectContext) -> Rateio? {
        return tabela(context).first { _ in NSPredicate(format: "pagamento.id = %@ and usuario.id = %@", (pagamento.id ?? UUID()) as CVarArg, (usuario.id ?? UUID()) as CVarArg) }
    }
}
