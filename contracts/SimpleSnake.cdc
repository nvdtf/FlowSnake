import SimpleRules from "./engine/SimpleRules.cdc"
import Util from "./engine/Util.cdc"

pub contract SimpleSnake {

    pub resource Snake {

        pub var game: &SimpleRules.Rules?

        init() {
            self.game = nil
        }

        pub fun move(playerIndex: UInt8, game: &SimpleRules.Rules): String {

            self.game = game

            let myHead = game.players[playerIndex].getHead()

            let boardSize = game.board.getSize()

            var targetCell = Util.Coordination(X: 0, Y: 0)

            var minDistance: UInt8 = 255
            for k in game.fruits.keys {
                let fruit = game.fruits[k]!
                let d = self.calculateDistance(a: myHead, b: fruit)
                if d < minDistance {
                    targetCell = fruit
                    minDistance = d
                }
            }

            let moves = "RLDU"

            var i = -1
            if targetCell.X > myHead.X {
                i = 0
            } else if targetCell.X < myHead.X {
                i = 1
            } else if targetCell.Y > myHead.Y {
                i = 2
            } else if targetCell.Y < myHead.Y {
                i = 3
            }

            var maxTries = 4
            while (maxTries > 0) {
                let m = moves[i]
                if self.checkValid(cell: myHead, move: m) {
                    return m.toString()
                }
                maxTries = maxTries - 1
                i = i + 1
                if i == moves.length {
                    i = 0
                }
            }

            return "?"
        }

        pub fun checkValid(cell: Util.Coordination, move: Character): Bool {

            let boardSize = self.game!.board.getSize()

            var X: Int = Int(cell.X)
            var Y: Int = Int(cell.Y)

            if move == "R" {
                X = X + 1
            } else if move == "L" {
                X = X - 1
            } else if move == "U" {
                Y = Y - 1
            } else if move == "D" {
                Y = Y + 1
            } else {
                return false
            }

            if X < 0 || Y < 0 || X >= Int(boardSize) || Y >= Int(boardSize) {
                return false
            }

            if let o = self.game!.objects[X.toString().concat(",").concat(Y.toString())] {
                if o.keys[0] == "F" {
                    return true
                } else {
                    return false
                }
            }
            return true
        }

        pub fun calculateDistance(a: Util.Coordination, b: Util.Coordination): UInt8 {
            var Xd: UInt8 = 0
            if a.X > b.X {
                Xd = a.X - b.X
            } else {
                Xd = b.X - a.X
            }
            var Yd: UInt8 = 0
            if a.Y > b.Y {
                Yd = a.Y - b.Y
            } else {
                Yd = b.Y - a.Y
            }
            return Xd + Yd
        }

    }

    pub fun createSnake(): @Snake {
        return <- create Snake()
    }

}