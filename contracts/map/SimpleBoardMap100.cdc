import SimpleModels from "../engine/SimpleModels.cdc"
import Util from "../engine/Util.cdc"

pub contract SimpleBoardMap100 {

    pub struct Board: SimpleModels.Board {

        pub let size: UInt8
        pub let playerSpawn: {UInt8: [Util.Coordination]}
        pub let fruits: {UInt8: Util.Coordination}

        init() {
            self.size = 100
            self.playerSpawn = {
                0: [Util.Coordination(X: 1, Y: 1)],
                1: [Util.Coordination(X: self.size - 2, Y: 1)],
                2: [Util.Coordination(X: 1, Y: self.size - 2)],
                3: [Util.Coordination(X: self.size - 2, Y: self.size - 2)]
            }

            let fruitsX: [UInt8] = [30, 74, 90, 24, 92, 71, 45, 67, 4, 39, 15, 38, 14, 9, 69, 10, 17, 27, 62, 64, 1, 84, 46, 91, 28, 32, 37, 95, 22, 7, 29, 63, 55, 56, 44, 12, 85, 78, 58, 19, 52, 70, 96, 76, 75, 16, 93, 51, 11, 47]
            let fruitsY: [UInt8] = [11, 63, 70, 92, 24, 38, 49, 85, 61, 8, 3, 22, 28, 19, 66, 0, 48, 13, 36, 1, 96, 27, 7, 87, 75, 16, 99, 88, 74, 17, 5, 55, 95, 44, 35, 34, 57, 4, 59, 51, 90, 42, 45, 9, 40, 41, 21, 56, 97, 81]

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