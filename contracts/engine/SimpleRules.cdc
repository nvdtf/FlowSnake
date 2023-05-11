import SimpleModels from "./SimpleModels.cdc"
import Util from "./Util.cdc"

pub contract SimpleRules {

    pub struct PlayerData {

        pub let index: UInt8
        pub var body: [Util.Coordination]

        init(index: UInt8, initialBody: [Util.Coordination]) {
            self.index = index
            self.body = initialBody
        }

        pub fun getHead(): Util.Coordination {
            return self.body[0]
        }

        pub fun addToHead(cell: Util.Coordination) {
            self.body.insert(at: 0, cell)
        }

        pub fun dropTail() {
            self.body.remove(at: self.body.length - 1)
        }

    }

    pub resource Rules {

        pub let board: {SimpleModels.Board}

        pub let objects: {String: {String: UInt8}}

        pub let players: [PlayerData]

        pub let fruits: {UInt8: Util.Coordination}

        init(board: {SimpleModels.Board}) {
            self.board = board
            self.players = []
            self.fruits = {}
            self.objects = {}

            for f in board.getFruits().keys {
                self.addFruit(key: f, pos: board.getFruits()[f]!)
            }
        }

        pub fun addFruit(key: UInt8, pos: Util.Coordination) {
            self.fruits.insert(key: key, pos)
            self.objects.insert(key: pos.toString(), {"F": key})
        }

        pub fun registerPlayer(index: UInt8) {
            self.players.append(PlayerData(index: index, initialBody: self.board.getPlayerSpawns()[index]!))
        }

        pub fun processMove(_ playerIndex: UInt8, _ move: String): String {
            var newCell = self.players[playerIndex].getHead()
            if move == "R" {
                newCell.X = newCell.X + 1
            } else if move == "L" {
                newCell.X = newCell.X - 1
            } else if move == "U" {
                newCell.Y = newCell.Y - 1
            } else if move == "D" {
                newCell.Y = newCell.Y + 1
            }

            var fruitConsumed: Bool = false
            if let i = self.objects[newCell.toString()] {
                if let o = i["F"] {

                    self.fruits.remove(key: o)
                    self.objects.remove(key: newCell.toString())
                    fruitConsumed = true

                }
            }

            self.players[playerIndex].addToHead(cell: newCell)

            if !fruitConsumed {
                self.players[playerIndex].dropTail()
            }

            if self.checkEnd() {
                return "E"
            }
            return ""
        }

        pub fun calculateNewFruitPosition(): Util.Coordination {
            var sumX: UInt8 = 0
            var sumY: UInt8 = 0

            for fruitKey in self.fruits.keys {
                sumX = sumX + self.fruits[fruitKey]!.X
                sumY = sumY + self.fruits[fruitKey]!.Y
            }

            let res = Util.Coordination(X: sumX / UInt8(self.fruits.keys.length), Y: sumY / UInt8(self.fruits.keys.length))

            return res
        }

        pub fun checkEnd(): Bool {
            return self.fruits.length == 0
        }

        pub fun debugPrintBoard(): [[UInt8]] {

            var i: UInt8 = 0
            var board: [[UInt8]] = []
            while i < self.board.getSize() {
                board.append([])
                var j: UInt8 = 0
                while j < self.board.getSize() {
                    board[i].append(1)
                    j = j + 1
                }
                i = i + 1
            }

            for fruitKey in self.fruits.keys {
                board[self.fruits[fruitKey]!.X][self.fruits[fruitKey]!.Y] = 4
            }

            var k = 0
            while (k < self.players.length) {
                board[self.players[k].getHead().X][self.players[k].getHead().Y] = 3
                var m = 0
                while (m < self.players[k].body.length) {
                    board[self.players[k].body[m].X][self.players[k].body[m].Y] = 2
                    m = m + 1
                }
                k = k + 1
            }

            return board
        }

    }

    pub fun createRules(board: {SimpleModels.Board}): @Rules {
        return <- create Rules(board: board)
    }

}