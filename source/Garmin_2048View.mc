import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application;

class Garmin_2048View extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function tileColor(v) {
        var colors = {
            0 => 0x3C3A32, 2 => 0xEEE4DA, 4 => 0xEDE0C8, 8 => 0xF2B179,
            16 => 0xF59563, 32 => 0xF67C5F, 64 => 0xF65E3B, 128 => 0xEDCF72,
            256 => 0xEDCC61, 512 => 0xEDC850, 1024 => 0xEDC53F, 2048 => 0xEDC22E
        };
        return colors.hasKey(v) ? colors[v] : 0x3C3A32;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc) {
        var game = Application.getApp().game;
        var w = dc.getWidth();
        var h = dc.getHeight();

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        if (game.gameOver && game.showResults) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(w / 2, h * 0.22, Graphics.FONT_MEDIUM, "Game Over",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText(w / 2, h * 0.38, Graphics.FONT_SMALL, "Score " + game.score,
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText(w / 2, h * 0.48, Graphics.FONT_SMALL, "Best " + game.highScore,
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);

            var buttonWidth = w * 0.58;
            var buttonHeight = h * 0.12;
            var buttonX = (w - buttonWidth) / 2;
            var buttonY = h * 0.64;
            dc.setColor(0xEDC22E, Graphics.COLOR_TRANSPARENT);
            dc.fillRoundedRectangle(buttonX, buttonY, buttonWidth, buttonHeight, 8);
            dc.setColor(0x3C3A32, Graphics.COLOR_TRANSPARENT);
            dc.drawText(w / 2, buttonY + buttonHeight / 2, Graphics.FONT_SMALL, "Restart",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            return;
        }

        // Score at the top
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        if (game.gameOver) {
            dc.drawText(w / 2, h * 0.055, Graphics.FONT_XTINY, "Game Over",
                Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(w / 2, h * 0.105, Graphics.FONT_XTINY, "Score " + game.score,
                Graphics.TEXT_JUSTIFY_CENTER);
        } else {
            dc.drawText(w / 2, h * 0.08, Graphics.FONT_XTINY, "Score " + game.score,
                Graphics.TEXT_JUSTIFY_CENTER);
        }

        // Grid sized to fit inside a round screen
        var side = (w * 0.68).toNumber();
        var cell = side / 4;
        var left = (w - side) / 2;
        var top = (h - side) / 2 + (h * 0.04).toNumber();

        for (var r = 0; r < 4; r++) {
            for (var c = 0; c < 4; c++) {
                var v = game.board[r][c];
                var x = left + c * cell;
                var y = top + r * cell;
                dc.setColor(tileColor(v), Graphics.COLOR_TRANSPARENT);
                dc.fillRoundedRectangle(x + 2, y + 2, cell - 4, cell - 4, 6);
                if (v != 0) {
                    dc.setColor(v <= 4 ? 0x776E65 : Graphics.COLOR_WHITE,
                        Graphics.COLOR_TRANSPARENT);
                    dc.drawText(x + cell / 2, y + cell / 2, Graphics.FONT_XTINY, v.toString(),
                        Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
                }
            }
        }

        if (game.gameOver) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(w / 2, h * 0.9, Graphics.FONT_XTINY, "Tap to continue",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
