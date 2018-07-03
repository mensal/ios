import Foundation

class AppConfig {

    // MARK: - Conveniência

    static let shared = AppConfig()

    // MARK: - Propriedades

    let authHeader = ["Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjZWE4ZGMxNC0zZmJmLTQyOGUtODgxMi05NjY5NGEwMzFkZjMiLCJuYW1lIjoiQ2xldmVyc29uIiwiaXNzIjoiaHR0cDovL3Rlc3RlIiwiZXhwIjoxNTMwOTgyMDI3LCJpYXQiOjE1MzA1NTAwMjd9.OrJuKGy9diDj-9iNsILJY93he4Vq_BQ_cEKj1SBn6Sef0i6P0gj0lWq6md8b0nDvK1LrGs-JnrvH0i9O47WwGg"]

    let apiBaseUrl = URL(string: "https://wildfly-mensal.a3c1.starter-us-west-1.openshiftapps.com/api")!

    // MARK: - Construtores

    private init() {
    }
}
