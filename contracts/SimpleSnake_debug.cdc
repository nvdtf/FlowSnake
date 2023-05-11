import SimpleRules from "./engine/SimpleRules.cdc"
import Util from "./engine/Util.cdc"

pub contract SimpleSnake_debug {

    pub resource Snake {

        pub fun move(playerIndex: UInt8, game: &SimpleRules.Rules): String {

            let myHead = game.players[playerIndex].getHead()

            let boardSize = game.board.getSize()

            let boardPrinted = game.debugPrintBoard()

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

            if targetCell.X > myHead.X && myHead.X + 1 < boardSize && (boardPrinted[myHead.X + 1][myHead.Y] == 1 || boardPrinted[myHead.X + 1][myHead.Y] == 4) {
                return "R"
            } else if targetCell.X < myHead.X && myHead.X - 1 >= 0 && (boardPrinted[myHead.X - 1][myHead.Y] == 1 || boardPrinted[myHead.X - 1][myHead.Y] == 4) {
                return "L"
            } else if targetCell.Y > myHead.Y && myHead.Y + 1 < boardSize && (boardPrinted[myHead.X][myHead.Y + 1] == 1 || boardPrinted[myHead.X][myHead.Y + 1] == 4) {
                return "D"
            } else if targetCell.Y < myHead.Y && Int(myHead.Y) - 1 >= 0 && (boardPrinted[myHead.X][myHead.Y - 1] == 1 || boardPrinted[myHead.X][myHead.Y - 1] == 4) {
                return "U"
            }

            return "?"
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