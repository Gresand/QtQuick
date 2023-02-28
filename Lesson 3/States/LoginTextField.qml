import QtQuick 2.0
import QtQuick.Controls 2.12

TextField {
    id:textField
    Label {
        id:label
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 10
        text: "Логин"
        opacity: 0.5
        background: Rectangle {
            anchors.centerIn: parent
            width: parent.width + 5
            height: parent.height + 5
        }
        state: "normal"
        states: [
            State {
                name: "normal"
                when: !textField.focus && textField.text === ""
                PropertyChanges { target: label; anchors.verticalCenterOffset: 0; opacity: 0.5}
            },
            State {
                name: "Focus"
                when: (textField.focus && textField.text === "") || (textField.focus && textField.text !== "")
                PropertyChanges { target: label; anchors.verticalCenterOffset: -20; opacity: 1}
            },
            State {
                name: "NotFocus"
                when: !textField.focus && textField.text !== ""
                PropertyChanges {target: label; anchors.verticalCenterOffset: -20; opacity: 0.5}
            }
        ]
        transitions: [
            Transition {
                from: "Focus"
                to: "normal"
                reversible: true
                ParallelAnimation {
                PropertyAnimation { property: "anchors.verticalCenterOffset"; duration: 150 }
                PropertyAnimation { property: "opacity"; duration: 100 }
                }
            },
            Transition {
                from: "normal"
                to: "Focus"
                reversible: true
                ParallelAnimation {
                PropertyAnimation { property: "anchors.verticalCenterOffset"; duration: 150 }
                PropertyAnimation { property: "opacity"; duration: 100 }
                }
            },
            Transition {
                from: "Focus"
                to: "NotFocus"
                reversible: true
                PropertyAnimation { property: "opacity"; duration: 100 }
            }
        ]
    }
}
