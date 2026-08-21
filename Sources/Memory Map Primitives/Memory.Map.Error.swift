public import Error_Primitives

extension Memory.Map {

    public enum Error: Swift.Error, Sendable, Equatable, Hashable {

        case map(Error_Primitives.Error.Code)

        case unmap(Error_Primitives.Error.Code)

        case sync(Error_Primitives.Error.Code)

        case protect(Error_Primitives.Error.Code)

        case exhausted

        case invalid(Validation)
    }
}

extension Memory.Map.Error: CustomStringConvertible {

    public var description: Swift.String {
        switch self {
        case .map(let code):
            return "mmap failed (\(code))"

        case .unmap(let code):
            return "munmap failed (\(code))"

        case .sync(let code):
            return "msync failed (\(code))"

        case .protect(let code):
            return "mprotect failed (\(code))"

        case .exhausted:
            return "out of memory"

        case .invalid(let validation):
            return "invalid argument: \(validation)"
        }
    }
}
