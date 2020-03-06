import Vapor
import App
import FluentPostgreSQL

extension Application {
    static func testable(envArgs: [String]? = nil) throws -> Application {
        var config = Config.default()
        var services = Services.default()
        var env = Environment.testing
        
        if let enviromentArgs = envArgs {
            env.arguments = enviromentArgs
        }
        
        try App.configure(&config, &env, &services)
        let app = try Application(config: config, environment: env, services: services)
        try App.boot(app)
        
        return app
    }
    
    static func reset() throws {
        let revertEnviroment = ["vapor", "revert", "--all", "-y"]
        try Application.testable(envArgs: revertEnviroment).asyncRun().wait()
        
        let migrationEnviroment = ["vapor", "migrate", "-y"]
        try Application.testable(envArgs: migrationEnviroment).asyncRun().wait()
    }
}
