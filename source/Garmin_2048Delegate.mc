import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application;


class Garmin_2048Delegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function doMove(dir) {
        var game = Application.getApp().game;
        game.move(dir);
        game.save();
        WatchUi.requestUpdate();
    }

    function onSwipe(evt) {
        return true;
    }
    
    function onTap(evt) {
        var game = Application.getApp().game;
        if (game.gameOver) {
            if (!game.showResults) {
                game.showResults = true;
                game.save();
                WatchUi.requestUpdate();
                return true;
            }
            var coords = evt.getCoordinates();
            var settings = System.getDeviceSettings();
            var w = settings.screenWidth;
            var h = settings.screenHeight;
            var buttonWidth = w * 0.58;
            var buttonHeight = h * 0.12;
            var buttonX = (w - buttonWidth) / 2;
            var buttonY = h * 0.64;
            if (coords[0] >= buttonX && coords[0] <= buttonX + buttonWidth &&
                coords[1] >= buttonY && coords[1] <= buttonY + buttonHeight) {
                game.restart();
                game.save();
                WatchUi.requestUpdate();
            }
            return true;
        }
        var coords = evt.getCoordinates();
        var settings = System.getDeviceSettings();
        var dx = coords[0] - settings.screenWidth / 2;
        var dy = coords[1] - settings.screenHeight / 2;

        if (dx.abs() > dy.abs()) {
            doMove(dx < 0 ? Game2048.LEFT : Game2048.RIGHT);
        } else {
            doMove(dy < 0 ? Game2048.UP : Game2048.DOWN);
        }
        return true;
    }

}
