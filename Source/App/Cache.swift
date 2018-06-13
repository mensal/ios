import Foundation

class Cache<T: Any> {
    
    typealias CacheLoader = () -> [T]
    
    private let loader: CacheLoader
    
    private var _values: [T]?
    
    var values: [T] {
        get {
            if _values == nil {
                _values = loader()
            }
            
            return _values!
        }
    }
    
    init(_ loader: @escaping CacheLoader) {
        self.loader = loader
    }
    
    func clear() {
        _values = nil
    }
}
