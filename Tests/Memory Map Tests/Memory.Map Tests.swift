import Testing

@testable import Memory_Map

extension Memory.Map {
    @Suite struct Tests {
        @Test func `namespace is available`() {

            #expect(Bool(true))
        }
    }
}
