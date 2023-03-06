import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id:appPage
    width: parent.width
    height: parent.height
    color: "#0f0f0f"

    signal onLoggedOut()

    Component.onCompleted: console.log("App Page completed")
//    Component.onDestroyed: console.log("App Page destroyed") Почему-то с этой строчкой вылезает ошибка загрузки и нет возможности проверить удаляется ли компонент

    function logOut() {
        onLoggedOut()
        appPage.destroy()
    }
    Column {
        spacing: 10
        anchors.centerIn: parent
        Label {
            text:"Welcome"
        }
        Button {
            text: "Exit"
            onClicked: logOut()
        }
    }
}
