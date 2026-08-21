import Testing

@testable import Memory_Map_Primitives

extension Memory.Map {
    @Suite struct Tests {
        @Test func `namespace is available`() {

            #expect(Bool(true))
        }
    }
}
