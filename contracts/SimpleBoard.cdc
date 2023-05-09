pub contract SimpleBoard {

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
    }

    pub struct PlayerData {

        pub let index: UInt8
        pub let headPos: Coordination
        pub let body: [Coordination]

        init(index: UInt8) {

            self.index = index
            self.headPos = Coordination(X: 0, Y: 0)
            self.body = []

        }

    }

    pub resource Board {

        pub let size: UInt8

        pub let players: [PlayerData]

        init(size: UInt8) {
            self.size = size
            self.players = []
        }

        pub fun registerPlayer(index: UInt8) {
            self.players.append(PlayerData(index: index))
        }

        pub fun processMove(_ playerIndex: UInt8, _ move: String) {
            if move == "R" {
                self.players[playerIndex].headPos.X = self.players[playerIndex].headPos.X + 1
            } else if move == "L" {
                self.players[playerIndex].headPos.X = self.players[playerIndex].headPos.X - 1
            } else if move == "U" {
                self.players[playerIndex].headPos.Y = self.players[playerIndex].headPos.Y + 1
            } else if move == "D" {
                self.players[playerIndex].headPos.Y = self.players[playerIndex].headPos.Y - 1
            }
        }

        pub fun printBoard(): [[UInt8]] {

            var i: UInt8 = 0
            var result2: [[UInt8]] = []
            while i < self.size {
                result2.append([])
                var j: UInt8 = 0
                while j < self.size {
                    result2[i].append(1)
                    j = j + 1
                }
                i = i + 1
            }

            var k = 0
            while (k < self.players.length) {
                result2[self.players[k].headPos.X][self.players[k].headPos.Y] = 3
                var m = 0
                while (m < self.players[k].body.length) {
                    result2[self.players[k].body[m].X][self.players[k].body[m].Y] = 2
                    m = m + 1
                }
                k = k + 1
            }

            return result2
        }

    }

    pub fun createBoard(size: UInt8): @Board {
        return <- create Board(size: size)
    }

}