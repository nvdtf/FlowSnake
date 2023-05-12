import SimpleModels from "../engine/SimpleModels.cdc"
import Util from "../engine/Util.cdc"

pub contract SimpleBoardMap50 {

    pub struct Board: SimpleModels.Board {

        pub let size: UInt8
        pub let playerSpawn: {UInt8: [Util.Coordination]}
        pub let fruits: {UInt8: Util.Coordination}

        init() {
            self.size = 50
            self.playerSpawn = {
                0: [Util.Coordination(X: 1, Y: 1)],
                1: [Util.Coordination(X: self.size - 2, Y: 1)],
                2: [Util.Coordination(X: 1, Y: self.size - 2)],
                3: [Util.Coordination(X: self.size - 2, Y: self.size - 2)]
            }

            let fruitsX: [UInt8] = [9, 5, 33, 23, 14, 17, 28, 38, 8, 36, 4, 12, 46, 29, 15, 18, 30, 32, 44, 11, 48, 27, 31, 24, 22, 1, 6, 41, 45, 21, 42, 39, 37, 16, 34, 26, 40, 35, 7, 13, 19, 47, 2, 3, 49, 10, 25, 20, 0, 43]
            let fruitsY: [UInt8] = [25, 19, 41, 3, 4, 23, 22, 9, 15, 10, 39, 40, 49, 48, 8, 37, 46, 44, 35, 31, 45, 43, 27, 12, 13, 6, 21, 20, 33, 34, 14, 30, 42, 17, 2, 24, 28, 16, 11, 32, 29, 36, 38, 5, 0, 7, 18, 47, 26, 1]

            self.fruits = {}

            for i, x in fruitsX {
                self.fruits.insert(key: UInt8(i), Util.Coordination(X: x, Y: fruitsY[i]))
            }

        }

        pub fun getSize(): UInt8 {
            return self.size
        }

        pub fun getPlayerSpawns(): {UInt8: [Util.Coordination]} {
            return self.playerSpawn
        }

        pub fun getFruits(): {UInt8: Util.Coordination} {
            return self.fruits
        }

    }

}