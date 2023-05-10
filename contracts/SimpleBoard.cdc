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

        init(index: UInt8, headPos: Coordination) {

            self.index = index
            self.headPos = headPos
            self.body = []

        }

    }

    pub resource Board {

        pub let size: UInt8

        pub let players: [PlayerData]

        pub let fruits: [Coordination]

        init(size: UInt8, fruitCount: UInt8) {
            self.size = size
            self.players = []
            self.fruits = []

            let initialFruitPositions: [Coordination] = [
                Coordination(X: 0, Y: 0),
                Coordination(X: size - 1, Y: 0),
                Coordination(X: 0, Y: size - 1),
                Coordination(X: size - 1, Y: size - 1)
            ]

            var i: UInt8 = 0
            while i < fruitCount {
                self.fruits.append(initialFruitPositions[i])
                i = i + 1
            }
        }

        pub fun registerPlayer(index: UInt8) {
            var headPos = Coordination(X: 0, Y: 0)
            let border: UInt8 = 1
            if index == 0 {
                headPos = Coordination(X: border, Y: border)
            } else if index == 1 {
                headPos = Coordination(X: self.size-1-border, Y: border)
            } else if index == 2 {
                headPos = Coordination(X: self.size-1-border, Y: self.size-1-border)
            } else if index == 3 {
                headPos = Coordination(X: border, Y: self.size-1-border)
            } else if index == 4 {
                headPos = Coordination(X: self.size/2, Y: border)
            } else if index == 5 {
                headPos = Coordination(X: border, Y: self.size/2)
            } else if index == 6 {
                headPos = Coordination(X: self.size/2, Y: self.size-1-border)
            } else if index == 7 {
                headPos = Coordination(X: self.size-1-border, Y: self.size/2)
            }
            self.players.append(PlayerData(index: index, headPos: headPos))
        }

        pub fun processMove(_ playerIndex: UInt8, _ move: String) {
            if move == "R" {
                self.players[playerIndex].headPos.X = self.players[playerIndex].headPos.X + 1
            } else if move == "L" {
                self.players[playerIndex].headPos.X = self.players[playerIndex].headPos.X - 1
            } else if move == "U" {
                self.players[playerIndex].headPos.Y = self.players[playerIndex].headPos.Y - 1
            } else if move == "D" {
                self.players[playerIndex].headPos.Y = self.players[playerIndex].headPos.Y + 1
            }
        }

        pub fun printBoard(): [[UInt8]] {

            var i: UInt8 = 0
            var board: [[UInt8]] = []
            while i < self.size {
                board.append([])
                var j: UInt8 = 0
                while j < self.size {
                    board[i].append(1)
                    j = j + 1
                }
                i = i + 1
            }

            var k = 0
            while (k < self.players.length) {
                board[self.players[k].headPos.X][self.players[k].headPos.Y] = 3
                var m = 0
                while (m < self.players[k].body.length) {
                    board[self.players[k].body[m].X][self.players[k].body[m].Y] = 2
                    m = m + 1
                }
                k = k + 1
            }

            var f = 0
            while (f < self.fruits.length) {
                board[self.fruits[f].X][self.fruits[f].Y] = 4
                f = f + 1
            }

            return board
        }

    }

    pub fun createBoard(size: UInt8, fruitCount: UInt8): @Board {
        return <- create Board(size: size, fruitCount: fruitCount)
    }

}