import Vapor
import Fluent

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let acronymController = AcronymsController()
    try router.register(collection: acronymController)
}
