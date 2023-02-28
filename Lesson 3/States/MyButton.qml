import QtQuick 2.0
import QtQuick.Controls 2.12

Button {
    id:but
    width: 100
    height: 40
    background: Rectangle {
        anchors.fill: parent
        color: parent.down ? "#bbbbbb" : parent.hovered ?  "#d8d8d8" : "#c1c1c1"
        Label {
            id:textBut
            anchors.centerIn: parent
            text: "Вход"
            color: "White"
            font.pointSize: 10
            states: State { name: "hovered"; when: but.hovered; PropertyChanges { target:textBut; font.pointSize: 16} }
            transitions: Transition { to: "hovered"; reversible: true; PropertyAnimation {property: "font.pointSize"; duration: 70} }
        }
    }
}
