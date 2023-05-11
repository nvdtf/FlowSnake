pub contract Util {

    pub struct Coordination {

        pub(set) var X: UInt8
        pub(set) var Y: UInt8

        init(
            X: UInt8,
            Y: UInt8,
        ) {
            self.X = X
            self.Y = Y
        }

        pub fun toString(): String {
            return self.X.toString().concat(",".concat(self.Y.toString()))
        }
    }

}