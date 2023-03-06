import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Dynamic Application")

    property var component: 0
    property var loginPage: null
    property var appPage: null

    Component.onCompleted: loadLoginPage()

    function loadLoginPage() {
        if(appPage) {
            appPage.destroy()
            appPage = null
        }
        if(!loginPage) {
            component = Qt.createComponent("LoginPage.qml")
            if(component.status === Component.Ready) {
                loginPage = component.createObject(mainWindow)
                loginPage.onLoggedIn.connect(loadAppPage)
            } else {
                console.log("Error load")
            }
        }
    }

    function loadAppPage() {
        if(loginPage) {
            loginPage.destroy()
            loginPage = null
        }
        if(!appPage) {
            component = Qt.createComponent("AppPage.qml")
            if(component.status === Component.Ready) {
                appPage = component.createObject(mainWindow)
                appPage.onLoggedOut.connect(loadLoginPage)
            } else {
                console.log("Error load")
            }
        }
    }
}
