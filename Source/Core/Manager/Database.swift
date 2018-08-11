import Foundation
import CoreData
import AlecrimCoreData

let persistentContainer = Database.shared.persistentContainer

class Database {

    lazy var persistentContainer = Database.loadPersistentContainer()

    static var shared = Database()

    private init() {
    }

    private static func loadPersistentContainer() -> PersistentContainer {
        let name = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let container = PersistentContainer(name: name, automaticallyLoadPersistentStores: false)

        loadPersistentStores(container)

        return container
    }

    private static func loadPersistentStores(_ container: PersistentContainer, _ isFirstAttempt: Bool = true) {
        container.loadPersistentStores { description, error in

            if let error = error /*as NSError?*/ {
                if isFirstAttempt {
                    destroyPersistentStore(container, description)
                } else {
                    showError(error)
                }
            }
        }
    }

    private static func destroyPersistentStore(_ container: PersistentContainer, _ description: PersistentStoreDescription) {
        if let url = description.url {

            try? container.persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: NSSQLiteStoreType, options: nil)
            loadPersistentStores(container, false)
        }
    }

    private static func showError(_ error: Error) {
        let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
            fatalError("Erro ao recriar banco de dados. \(error)")
        }

        let alert = UIAlertController(title: nil, message: "Falha ao carregar o banco de dados.", preferredStyle: .alert)
        alert.addAction(action)

        let vc = AppDelegate.shared.window?.rootViewController
        vc?.present(alert, animated: true)
    }
}
