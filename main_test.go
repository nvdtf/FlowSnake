package tests

import (
	"testing"

	"github.com/bjartek/overflow"
)

func TestDeployContracts(t *testing.T) {
	overflow.Overflow()
}

func TestNewGame(t *testing.T) {
	o := overflow.Overflow()

	o.Tx(
		"new_game",
		overflow.WithSigner("gamer"),
		overflow.WithArg("snakeCount", 1),
	).Print()

	t.Fail()

}
