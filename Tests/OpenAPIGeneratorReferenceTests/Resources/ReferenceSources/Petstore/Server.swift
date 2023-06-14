// Generated by swift-openapi-generator, do not modify.
@_spi(Generated) import OpenAPIRuntime
#if os(Linux)
@preconcurrency import Foundation
#else
import Foundation
#endif
extension APIProtocol {
    /// Registers each operation handler with the provided transport.
    /// - Parameters:
    ///   - transport: A transport to which to register the operation handlers.
    ///   - serverURL: A URL used to determine the path prefix for registered
    ///   request handlers.
    ///   - configuration: A set of configuration values for the server.
    ///   - middlewares: A list of middlewares to call before the handler.
    public func registerHandlers(
        on transport: ServerTransport,
        serverURL: URL = .defaultOpenAPIServerURL,
        configuration: Configuration = .init(),
        middlewares: [ServerMiddleware] = []
    ) throws {
        let server = UniversalServer(
            serverURL: serverURL,
            handler: self,
            configuration: configuration,
            middlewares: middlewares
        )
        try transport.register(
            { try await server.listPets(request: $0, metadata: $1) },
            method: .get,
            path: server.apiPathComponentsWithServerPrefix(["pets"]),
            queryItemNames: ["limit", "habitat", "feeds", "since"]
        )
        try transport.register(
            { try await server.createPet(request: $0, metadata: $1) },
            method: .post,
            path: server.apiPathComponentsWithServerPrefix(["pets"]),
            queryItemNames: []
        )
        try transport.register(
            { try await server.probe(request: $0, metadata: $1) },
            method: .post,
            path: server.apiPathComponentsWithServerPrefix(["probe"]),
            queryItemNames: []
        )
        try transport.register(
            { try await server.updatePet(request: $0, metadata: $1) },
            method: .patch,
            path: server.apiPathComponentsWithServerPrefix(["pets", ":petId"]),
            queryItemNames: []
        )
        try transport.register(
            { try await server.uploadAvatarForPet(request: $0, metadata: $1) },
            method: .put,
            path: server.apiPathComponentsWithServerPrefix(["pets", ":petId", "avatar"]),
            queryItemNames: []
        )
    }
}
fileprivate extension UniversalServer where APIHandler: APIProtocol {
    /// List all pets
    ///
    /// You can fetch all the pets here
    ///
    /// - Remark: Makes a HTTP `GET` request on `/pets`.
    /// - Remark: Generated from `#/paths//pets/get(listPets)`.
    func listPets(request: Request, metadata: ServerRequestMetadata) async throws -> Response {
        try await handle(
            request: request,
            with: metadata,
            forOperation: Operations.listPets.id,
            using: APIHandler.listPets,
            deserializer: { request, metadata in let path: Operations.listPets.Input.Path = .init()
                let query: Operations.listPets.Input.Query = .init(
                    limit: try converter.getOptionalQueryItemAsText(
                        in: metadata.queryParameters,
                        name: "limit",
                        as: Swift.Int32.self
                    ),
                    habitat: try converter.getOptionalQueryItemAsText(
                        in: metadata.queryParameters,
                        name: "habitat",
                        as: Operations.listPets.Input.Query.habitatPayload.self
                    ),
                    feeds: try converter.getOptionalQueryItemAsText(
                        in: metadata.queryParameters,
                        name: "feeds",
                        as: Operations.listPets.Input.Query.feedsPayload.self
                    ),
                    since: try converter.getOptionalQueryItemAsText(
                        in: metadata.queryParameters,
                        name: "since",
                        as: Components.Parameters.query_born_since.self
                    )
                )
                let headers: Operations.listPets.Input.Headers = .init(
                    My_Request_UUID: try converter.getOptionalHeaderFieldAsText(
                        in: request.headerFields,
                        name: "My-Request-UUID",
                        as: Swift.String.self
                    )
                )
                let cookies: Operations.listPets.Input.Cookies = .init()
                let body: Operations.listPets.Input.Body? = nil
                return Operations.listPets.Input(
                    path: path,
                    query: query,
                    headers: headers,
                    cookies: cookies,
                    body: body
                )
            },
            serializer: { output, request in
                switch output {
                case let .ok(value):
                    suppressUnusedWarning(value)
                    var response: Response = .init(statusCode: 200)
                    suppressMutabilityWarning(&response)
                    try converter.setHeaderFieldAsText(
                        in: &response.headerFields,
                        name: "My-Response-UUID",
                        value: value.headers.My_Response_UUID
                    )
                    try converter.setHeaderFieldAsText(
                        in: &response.headerFields,
                        name: "My-Tracing-Header",
                        value: value.headers.My_Tracing_Header
                    )
                    try converter.validateAcceptIfPresent(
                        "application/json",
                        in: request.headerFields
                    )
                    response.body = try converter.setResponseBodyAsJSON(
                        value.body,
                        headerFields: &response.headerFields,
                        transforming: { wrapped in
                            switch wrapped {
                            case let .json(value):
                                return .init(
                                    value: value,
                                    contentType: "application/json; charset=utf-8"
                                )
                            }
                        }
                    )
                    return response
                case let .`default`(statusCode, value):
                    suppressUnusedWarning(value)
                    var response: Response = .init(statusCode: statusCode)
                    suppressMutabilityWarning(&response)
                    try converter.validateAcceptIfPresent(
                        "application/json",
                        in: request.headerFields
                    )
                    response.body = try converter.setResponseBodyAsJSON(
                        value.body,
                        headerFields: &response.headerFields,
                        transforming: { wrapped in
                            switch wrapped {
                            case let .json(value):
                                return .init(
                                    value: value,
                                    contentType: "application/json; charset=utf-8"
                                )
                            }
                        }
                    )
                    return response
                }
            }
        )
    }
    /// Create a pet
    ///
    /// - Remark: Makes a HTTP `POST` request on `/pets`.
    /// - Remark: Generated from `#/paths//pets/post(createPet)`.
    func createPet(request: Request, metadata: ServerRequestMetadata) async throws -> Response {
        try await handle(
            request: request,
            with: metadata,
            forOperation: Operations.createPet.id,
            using: APIHandler.createPet,
            deserializer: { request, metadata in let path: Operations.createPet.Input.Path = .init()
                let query: Operations.createPet.Input.Query = .init()
                let headers: Operations.createPet.Input.Headers = .init(
                    X_Extra_Arguments: try converter.getOptionalHeaderFieldAsJSON(
                        in: request.headerFields,
                        name: "X-Extra-Arguments",
                        as: Components.Schemas.CodeError.self
                    )
                )
                let cookies: Operations.createPet.Input.Cookies = .init()
                let body: Operations.createPet.Input.Body =
                    try converter.getRequiredRequestBodyAsJSON(
                        Components.Schemas.CreatePetRequest.self,
                        from: request.body,
                        transforming: { value in .json(value) }
                    )
                return Operations.createPet.Input(
                    path: path,
                    query: query,
                    headers: headers,
                    cookies: cookies,
                    body: body
                )
            },
            serializer: { output, request in
                switch output {
                case let .created(value):
                    suppressUnusedWarning(value)
                    var response: Response = .init(statusCode: 201)
                    suppressMutabilityWarning(&response)
                    try converter.setHeaderFieldAsJSON(
                        in: &response.headerFields,
                        name: "X-Extra-Arguments",
                        value: value.headers.X_Extra_Arguments
                    )
                    try converter.validateAcceptIfPresent(
                        "application/json",
                        in: request.headerFields
                    )
                    response.body = try converter.setResponseBodyAsJSON(
                        value.body,
                        headerFields: &response.headerFields,
                        transforming: { wrapped in
                            switch wrapped {
                            case let .json(value):
                                return .init(
                                    value: value,
                                    contentType: "application/json; charset=utf-8"
                                )
                            }
                        }
                    )
                    return response
                case let .badRequest(value):
                    suppressUnusedWarning(value)
                    var response: Response = .init(statusCode: 400)
                    suppressMutabilityWarning(&response)
                    try converter.setHeaderFieldAsText(
                        in: &response.headerFields,
                        name: "X-Reason",
                        value: value.headers.X_Reason
                    )
                    try converter.validateAcceptIfPresent(
                        "application/json",
                        in: request.headerFields
                    )
                    response.body = try converter.setResponseBodyAsJSON(
                        value.body,
                        headerFields: &response.headerFields,
                        transforming: { wrapped in
                            switch wrapped {
                            case let .json(value):
                                return .init(
                                    value: value,
                                    contentType: "application/json; charset=utf-8"
                                )
                            }
                        }
                    )
                    return response
                case let .undocumented(statusCode, _): return .init(statusCode: statusCode)
                }
            }
        )
    }
    /// - Remark: Makes a HTTP `POST` request on `/probe`.
    /// - Remark: Generated from `#/paths//probe/post(probe)`.
    func probe(request: Request, metadata: ServerRequestMetadata) async throws -> Response {
        try await handle(
            request: request,
            with: metadata,
            forOperation: Operations.probe.id,
            using: APIHandler.probe,
            deserializer: { request, metadata in let path: Operations.probe.Input.Path = .init()
                let query: Operations.probe.Input.Query = .init()
                let headers: Operations.probe.Input.Headers = .init()
                let cookies: Operations.probe.Input.Cookies = .init()
                let body: Operations.probe.Input.Body? = nil
                return Operations.probe.Input(
                    path: path,
                    query: query,
                    headers: headers,
                    cookies: cookies,
                    body: body
                )
            },
            serializer: { output, request in
                switch output {
                case let .noContent(value):
                    suppressUnusedWarning(value)
                    var response: Response = .init(statusCode: 204)
                    suppressMutabilityWarning(&response)
                    return response
                case let .undocumented(statusCode, _): return .init(statusCode: statusCode)
                }
            }
        )
    }
    /// Update just a specific property of an existing pet. Nothing is updated if no request body is provided.
    ///
    /// - Remark: Makes a HTTP `PATCH` request on `/pets/{petId}`.
    /// - Remark: Generated from `#/paths//pets/{petId}/patch(updatePet)`.
    func updatePet(request: Request, metadata: ServerRequestMetadata) async throws -> Response {
        try await handle(
            request: request,
            with: metadata,
            forOperation: Operations.updatePet.id,
            using: APIHandler.updatePet,
            deserializer: { request, metadata in
                let path: Operations.updatePet.Input.Path = .init(
                    petId: try converter.getPathParameterAsText(
                        in: metadata.pathParameters,
                        name: "petId",
                        as: Swift.Int64.self
                    )
                )
                let query: Operations.updatePet.Input.Query = .init()
                let headers: Operations.updatePet.Input.Headers = .init()
                let cookies: Operations.updatePet.Input.Cookies = .init()
                let body: Components.RequestBodies.UpdatePetRequest? =
                    try converter.getOptionalRequestBodyAsJSON(
                        Components.RequestBodies.UpdatePetRequest.jsonPayload.self,
                        from: request.body,
                        transforming: { value in .json(value) }
                    )
                return Operations.updatePet.Input(
                    path: path,
                    query: query,
                    headers: headers,
                    cookies: cookies,
                    body: body
                )
            },
            serializer: { output, request in
                switch output {
                case let .noContent(value):
                    suppressUnusedWarning(value)
                    var response: Response = .init(statusCode: 204)
                    suppressMutabilityWarning(&response)
                    return response
                case let .badRequest(value):
                    suppressUnusedWarning(value)
                    var response: Response = .init(statusCode: 400)
                    suppressMutabilityWarning(&response)
                    try converter.validateAcceptIfPresent(
                        "application/json",
                        in: request.headerFields
                    )
                    response.body = try converter.setResponseBodyAsJSON(
                        value.body,
                        headerFields: &response.headerFields,
                        transforming: { wrapped in
                            switch wrapped {
                            case let .json(value):
                                return .init(
                                    value: value,
                                    contentType: "application/json; charset=utf-8"
                                )
                            }
                        }
                    )
                    return response
                case let .undocumented(statusCode, _): return .init(statusCode: statusCode)
                }
            }
        )
    }
    /// Upload an avatar
    ///
    /// - Remark: Makes a HTTP `PUT` request on `/pets/{petId}/avatar`.
    /// - Remark: Generated from `#/paths//pets/{petId}/avatar/put(uploadAvatarForPet)`.
    func uploadAvatarForPet(request: Request, metadata: ServerRequestMetadata) async throws
        -> Response
    {
        try await handle(
            request: request,
            with: metadata,
            forOperation: Operations.uploadAvatarForPet.id,
            using: APIHandler.uploadAvatarForPet,
            deserializer: { request, metadata in
                let path: Operations.uploadAvatarForPet.Input.Path = .init(
                    petId: try converter.getPathParameterAsText(
                        in: metadata.pathParameters,
                        name: "petId",
                        as: Components.Parameters.path_petId.self
                    )
                )
                let query: Operations.uploadAvatarForPet.Input.Query = .init()
                let headers: Operations.uploadAvatarForPet.Input.Headers = .init()
                let cookies: Operations.uploadAvatarForPet.Input.Cookies = .init()
                let body: Operations.uploadAvatarForPet.Input.Body =
                    try converter.getRequiredRequestBodyAsBinary(
                        Foundation.Data.self,
                        from: request.body,
                        transforming: { value in .binary(value) }
                    )
                return Operations.uploadAvatarForPet.Input(
                    path: path,
                    query: query,
                    headers: headers,
                    cookies: cookies,
                    body: body
                )
            },
            serializer: { output, request in
                switch output {
                case let .ok(value):
                    suppressUnusedWarning(value)
                    var response: Response = .init(statusCode: 200)
                    suppressMutabilityWarning(&response)
                    try converter.validateAcceptIfPresent(
                        "application/octet-stream",
                        in: request.headerFields
                    )
                    response.body = try converter.setResponseBodyAsBinary(
                        value.body,
                        headerFields: &response.headerFields,
                        transforming: { wrapped in
                            switch wrapped {
                            case let .binary(value):
                                return .init(value: value, contentType: "application/octet-stream")
                            }
                        }
                    )
                    return response
                case let .preconditionFailed(value):
                    suppressUnusedWarning(value)
                    var response: Response = .init(statusCode: 412)
                    suppressMutabilityWarning(&response)
                    try converter.validateAcceptIfPresent(
                        "application/json",
                        in: request.headerFields
                    )
                    response.body = try converter.setResponseBodyAsJSON(
                        value.body,
                        headerFields: &response.headerFields,
                        transforming: { wrapped in
                            switch wrapped {
                            case let .json(value):
                                return .init(
                                    value: value,
                                    contentType: "application/json; charset=utf-8"
                                )
                            }
                        }
                    )
                    return response
                case let .internalServerError(value):
                    suppressUnusedWarning(value)
                    var response: Response = .init(statusCode: 500)
                    suppressMutabilityWarning(&response)
                    try converter.validateAcceptIfPresent("text/plain", in: request.headerFields)
                    response.body = try converter.setResponseBodyAsText(
                        value.body,
                        headerFields: &response.headerFields,
                        transforming: { wrapped in
                            switch wrapped {
                            case let .text(value):
                                return .init(value: value, contentType: "text/plain")
                            }
                        }
                    )
                    return response
                case let .undocumented(statusCode, _): return .init(statusCode: statusCode)
                }
            }
        )
    }
}
