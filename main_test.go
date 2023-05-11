package tests

import (
	"testing"

	"github.com/bjartek/overflow"
)

func TestDeployContracts(t *testing.T) {
	overflow.Overflow()
}

func TestNewGameMap_10_1Player(t *testing.T) {
	o := overflow.Overflow()

	o.Tx(
		"new_game_10",
		overflow.WithSigner("gamer"),
		overflow.WithArg("snakeCount", 1),
	).Print()

	// LURRDDRRRRRULLDDDDRRDDD

	t.Fail()

}

func TestNewGameMap_10_4Player(t *testing.T) {
	o := overflow.Overflow()

	o.Tx(
		"new_game_10",
		overflow.WithSigner("gamer"),
		overflow.WithArg("snakeCount", 4),
	).Print()

	// LLRLULRLRLRLRLUUDLUUDDUU

	t.Fail()

}
