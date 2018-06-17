import Foundation

class AppConfig {

    // MARK: - Conveniência

    static let shared = AppConfig()

    // MARK: - Propriedades

    let authHeader = ["Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjZWE4ZGMxNC0zZmJmLTQyOGUtODgxMi05NjY5NGEwMzFkZjMiLCJuYW1lIjoiQ2xldmVyc29uIiwiaXNzIjoiaHR0cDovL3Rlc3RlIiwiZXhwIjoxNTI5MzI0NTYzLCJpYXQiOjE1Mjg4OTI1NjN9.Bxp0US3oymocVf310y71rqpWjO8CoOiTUSs190cQOZRvUeTLyFjQHzd1xuiaeWf0SvTleijmKIfvDoTaoAKHXg"]

    let apiBaseUrl = "https://despesas-despesas.a3c1.starter-us-west-1.openshiftapps.com/api"

    // MARK: - Construtores

    private init() {
    }
}
