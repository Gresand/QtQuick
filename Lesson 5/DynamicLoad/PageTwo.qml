import QtQuick 2.12
import QtQuick.Controls 2.15
import "FunctionDynamicLoad.js" as FDL

Item {
    id: page2
    anchors.fill: parent

    Rectangle { anchors.fill: parent; color: "#e5ecef" }

    Rectangle {
        id: framePage2
        color: "white"
        anchors.centerIn: parent
        radius: 5
        width: 300
        height: 250


        property string textColor: "#535353"
        Column {
            anchors.fill: parent
            padding: 32
            spacing: 32

            Label {
                id: labelPage2
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Здесь должна быть страница после входа"
            }

            Button {
                id: buttomExit
                width: 200
                height: 40
                background: Rectangle {
                    color: parent.down ? "#bbbbbb" :
                                         (parent.hovered ? "#d6d6d6" : "#f6f6f6")
                }
                text: qsTr("Вход")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    FDL.createSpriteObjects("PageEnter", spriteContainer);
                    page2.destroy();
                }
            }
        }
    }
}
