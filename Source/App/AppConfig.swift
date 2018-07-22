import Foundation

class AppConfig {

    // MARK: - Conveniência

    static let shared = AppConfig()

    // MARK: - Propriedades

    let authHeader = ["Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjZWE4ZGMxNC0zZmJmLTQyOGUtODgxMi05NjY5NGEwMzFkZjMiLCJuYW1lIjoiQ2xldmVyc29uIiwiaXNzIjoiaHR0cDovL3Rlc3RlIiwiZXhwIjoxNTMyNzAyNDU1LCJpYXQiOjE1MzIyNzA0NTV9.Mz1C7di9D1Xf_fkLqg2nHTQn3Jd6VkqOzu5m3pxt10uOzV4NR5EUH6nlCAM7H2GSgHuBztinIeiXmG4Ypt7lEw"]

    let apiBaseUrl = URL(string: "https://wildfly-mensal.a3c1.starter-us-west-1.openshiftapps.com/api")!
//    let apiBaseUrl = URL(string: "http://ZyC-MacBook.local:8080/api")!

    // MARK: - Construtores

    private init() {
    }
}
