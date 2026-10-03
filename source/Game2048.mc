import Toybox.Math;
import Toybox.System;
import Toybox.Application.Storage;

class Game2048 {
    // Directions
    static const LEFT = 0;
    static const RIGHT = 1;
    static const UP = 2;
    static const DOWN = 3;

    var board;
    var score = 0;
    var gameOver = false;
    var showResults = false;
    var highScore = 0;

    function save() {
        Storage.setValue("board", board);
        Storage.setValue("score", score);
        Storage.setValue("gameOver", gameOver);
        Storage.setValue("showResults", showResults);
        Storage.setValue("highScore", highScore);
    }

    function load() {
        var b = Storage.getValue("board");
        if (b != null) {
            board = b;
            score = Storage.getValue("score");
            gameOver = Storage.getValue("gameOver");
            var results = Storage.getValue("showResults");
            showResults = results == true;
        } else {
            initialize();
        }
        var hs = Storage.getValue("highScore");
        if (hs != null) { highScore = hs; }
    }

    function restart() {
        board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]];
        score = 0;
        gameOver = false;
        showResults = false;
        addTile();
        addTile();
    }

    function initialize() {
        Math.srand(System.getTimer());
        board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]];
        addTile();
        addTile();
    }

    // Maps "line i, position j" to a board cell for each direction
    function rowFor(dir, i, j) {
        if (dir == LEFT || dir == RIGHT) { return i; }
        if (dir == UP) { return j; }
        return 3 - j;
    }

    function colFor(dir, i, j) {
        if (dir == LEFT) { return j; }
        if (dir == RIGHT) { return 3 - j; }
        return i;
    }

    // Slide and merge one line toward index 0
    function slide(line) {
        var tiles = [];
        for (var n = 0; n < 4; n++) {
            if (line[n] != 0) { tiles.add(line[n]); }
        }
        var out = [];
        var k = 0;
        while (k < tiles.size()) {
            if (k + 1 < tiles.size() && tiles[k] == tiles[k + 1]) {
                var merged = tiles[k] * 2;
                out.add(merged);
                score += merged;
                k += 2;
            } else {
                out.add(tiles[k]);
                k += 1;
            }
        }
        while (out.size() < 4) { out.add(0); }
        return out;
    }

    function move(dir) {
        if (gameOver) { return false; }
        var moved = false;
        for (var i = 0; i < 4; i++) {
            var line = [];
            for (var j = 0; j < 4; j++) {
                line.add(board[rowFor(dir, i, j)][colFor(dir, i, j)]);
            }
            var result = slide(line);
            for (var j = 0; j < 4; j++) {
                var r = rowFor(dir, i, j);
                var c = colFor(dir, i, j);
                if (board[r][c] != result[j]) {
                    board[r][c] = result[j];
                    moved = true;
                }
            }
        }
        if (moved) {
            addTile();
            gameOver = !canMove();
            if (gameOver) { showResults = false; }
            if (score > highScore) { highScore = score; }
            save();
        }
        return moved;
    }

    function addTile() {
        var empty = [];
        for (var r = 0; r < 4; r++) {
            for (var c = 0; c < 4; c++) {
                if (board[r][c] == 0) { empty.add([r, c]); }
            }
        }
        if (empty.size() == 0) { return; }
        var pick = empty[Math.rand() % empty.size()];
        board[pick[0]][pick[1]] = (Math.rand() % 10 == 0) ? 4 : 2;
    }

    function canMove() {
        for (var r = 0; r < 4; r++) {
            for (var c = 0; c < 4; c++) {
                if (board[r][c] == 0) { return true; }
                if (c < 3 && board[r][c] == board[r][c + 1]) { return true; }
                if (r < 3 && board[r][c] == board[r + 1][c]) { return true; }
            }
        }
        return false;
    }
}
