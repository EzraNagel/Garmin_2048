import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class Garmin_2048App extends Application.AppBase {
    var game;

    function initialize() {
        AppBase.initialize();
        game = new Game2048();
        game.load();

    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        game.save();
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new Garmin_2048View(), new Garmin_2048Delegate() ];
    }

}

function getApp() as Garmin_2048App {
    return Application.getApp() as Garmin_2048App;
}