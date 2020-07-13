@testable import App
import FluentPostgreSQL
import Crypto


extension User {
    static func create(
        name: String = "Luke",
        username: String? = nil,
        on connection: PostgreSQLConnection) throws -> User {
        let creatUsername: String
        
        if let suppliedUsername = username {
            creatUsername = suppliedUsername
        } else {
            creatUsername = UUID().uuidString
        }
        
        let password = try BCrypt.hash("password")
        let user = User(name: name, username: creatUsername, password: password)
        return try user.save(on: connection).wait()
    }
}


extension Acronym {
    static func create(
        short: String = "TIL",
        long: String = "Today I Learned",
        user: User? = nil,
        on connection: PostgreSQLConnection
    ) throws -> Acronym {
        var acronymUser = user
        
        if acronymUser == nil {
            acronymUser = try User.create(on: connection)
        }
        
        let acronym = Acronym(short: short, long: long, userID: acronymUser!.id!)
        
        return try acronym.save(on: connection).wait()
    }
}

extension App.Category {
    static func create(
        name: String = "Random",
        on connection: PostgreSQLConnection
    ) throws -> App.Category {
        let category = Category(name: name)
        return try category.save(on: connection).wait()
    }
}
