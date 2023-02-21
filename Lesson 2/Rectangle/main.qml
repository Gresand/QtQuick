import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 500
    height: 500
    title: qsTr("Hello World")

    Item {
        anchors.fill: parent
        anchors.margins: 150
        Rectangle {
            id:rec
            height: parent.height
            width: parent.width
            color: "red"
            radius: 0
            MouseArea {
                id:mouse
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                onClicked: {
                    if(mouse.button === Qt.LeftButton) rec.color = Qt.rgba(Math.random(255), Math.random(255), Math.random(255))
                    if(mouse.button === Qt.RightButton) rot360.start()
                    //Бесконечная анимация вращения на колесико мыши
                    if(mouse.button === Qt.MiddleButton) infinityRot.running ? infinityRot.stop() : infinityRot.start()
                }
                onDoubleClicked: animRound.start()
            }
            ParallelAnimation {
                id: animRound
                RotationAnimation {target: rec; easing.type: Easing.InBack; to: rec.rotation + 180; duration: 1000}
                PropertyAnimation {target: rec; property: "radius"; to: (rec.radius == 0 ? 100 : 0); duration: 1000}
            }
            RotationAnimation  {id: rot360; target: rec; easing.type: Easing.InBack; from: 0; to: rec.rotation + 360; duration: 1000 }
            RotationAnimation on rotation {id: infinityRot; running: false; loops: Animation.Infinite; from: 0; to: 180; duration: 1000 }
            }
        }
}

