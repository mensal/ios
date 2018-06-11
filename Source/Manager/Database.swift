import Foundation
import CoreData
import AlecrimCoreData

func persistentContainer() -> PersistentContainer {
    return Database.shared.persistentContainer
}

class Database {

    static var shared = Database()

    lazy var persistentContainer = Database.loadPersistentContainer()

    private init() {
    }

    private static func loadPersistentContainer() -> PersistentContainer {
        let name = "Database"
        let container = PersistentContainer(name: name, automaticallyLoadPersistentStores: false)
        self.loadPersistentStores(container)

        return container
    }

    private static func loadPersistentStores(_ container: PersistentContainer, attempt: Int = 0) {
        container.loadPersistentStores { _, error in

            if let error = error as NSError? {
                if attempt == 0 {
                    let urls = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
                    var url = urls[urls.count - 1]
                    url = url.appendingPathComponent("Application Support/\(container.name).sqlite")

                    do {
                        try container.persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: NSSQLiteStoreType, options: nil)
                        print("Apagando o banco de dados")
                    } catch {
                        print("Falha ao tentar apagar o banco de dados: \(error)")
                    }

                    self.loadPersistentStores(container, attempt: attempt+1)

                } else {
                    let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
                        fatalError("Erro ao recriar banco de dados. \(error), \(error.userInfo)")
                    }

                    let alert = UIAlertController(title: nil, message: "Falha ao carregar o banco de dados.", preferredStyle: .alert)
                    alert.addAction(action)

                    let vc = AppDelegate.shared.window?.rootViewController
                    vc?.present(alert, animated: true)
                }
            } else {
                print("Banco de dados carregado")
            }
        }
    }
}
