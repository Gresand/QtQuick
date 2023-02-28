import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("States")
    color: "#e5ecef"

    property string login: "user"
    property string password:  "123"

    function check() {
        if (login == loginTextField.text
                && password == passwordTextField.text)
        {
            secondatyFrame.state = "Enter"
            thirdFrame.state = "Enter"
        }
        else
            fail.start()
    }

    Rectangle {
        id: secondatyFrame
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 5
        width: 300
        height: 250
        property string textColor: "#535353"
        state: "notEnter"
        states: [
            State {
                name: "notEnter"
                PropertyChanges { target: root; color: "#e5ecef" }
                PropertyChanges { target: colOne; opacity: 1 }
                PropertyChanges { target: loginTextField; opacity: 1}
                PropertyChanges { target: passwordTextField; opacity: 1}
            },
            State {
                name: "Enter"
                PropertyChanges { target: root; color: "lightgreen" }
                AnchorChanges { target: secondatyFrame; anchors.horizontalCenter: undefined}
                AnchorChanges { target: secondatyFrame; anchors.left: parent.left}
                PropertyChanges { target: colOne; opacity: 0 }
                PropertyChanges { target: loginTextField; opacity: 0}
                PropertyChanges { target: passwordTextField; opacity: 0}
                PropertyChanges { target: loginTextField; enabled: false}
                PropertyChanges { target: passwordTextField; enabled: false}
                PropertyChanges { target: buttonEnter; enabled: false}
            }
        ]
        transitions: [
            Transition {
                from: "notEnter"
                to: "Enter"
                ParallelAnimation {
                    PropertyAnimation {
                        targets: [loginTextField, passwordTextField,secondatyFrame]
                        property: "opacity"
                        to: 0
                        duration: 600
                    }
                    PropertyAnimation { target: secondatyFrame; property: "anchors.horizontalCenterOffset"; duration: 600}
                    AnchorAnimation { duration: 1000}
                    PropertyAnimation { target: colOne; property: "opacity"; duration: 1000}
                    ColorAnimation { target: root; duration: 600}
                }
            }
        ]
        Column {
            id:colOne
            anchors.fill: parent
            padding: 32
            spacing: 32
            LoginTextField {
                id: loginTextField
                anchors.horizontalCenter: parent.horizontalCenter
                color: secondatyFrame.textColor
                Keys.onEnterPressed: check()
                Keys.onReturnPressed: check()
            }
            PasswordTextField {
                id: passwordTextField
                anchors.horizontalCenter: parent.horizontalCenter
                color: secondatyFrame.textColor
                Keys.onEnterPressed: check()
                Keys.onReturnPressed: check()
            }
            MyButton {
                id: buttonEnter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: check()
            }
        }
    }

    Rectangle {
        id:support
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: 300
        height: 250
        visible: false
    }

    Rectangle {
        id: thirdFrame
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        radius: 5
        width: 300
        height: 250
        property string textColor: "#535353"
        state: "notEnter"
        states: [
            State {
                name: "notEnter"
                PropertyChanges { target: thirdFrame; opacity: 0}
            },
            State {
                name: "Enter"
                PropertyChanges { target: thirdFrame; opacity: 1}
                AnchorChanges { target: thirdFrame; anchors.right: undefined}
                AnchorChanges { target: thirdFrame; anchors.horizontalCenter: support.horizontalCenter }
            },
            State {
                name: "Loading"
                PropertyChanges { target: busyIndicator; running: true}
                PropertyChanges { target: loadLabel; opacity: 0}
                AnchorChanges { target: thirdFrame; anchors.right: parent.right}
                AnchorChanges { target: thirdFrame; anchors.left: parent.left}
                PropertyChanges {target: root; color: "light blue"}
            },
            State {
                name: "Loading done"
                PropertyChanges { target: busyIndicator; running: false}
                PropertyChanges { target: loadLabel; opacity: 1}
                PropertyChanges {target: root; color: "lightgreen"}
                AnchorChanges { target: thirdFrame; anchors.right: support.right}
                AnchorChanges { target: thirdFrame; anchors.left: support.left}
            }
        ]
        transitions: [
            Transition {
                from: "notEnter"
                to: "Enter"
                ParallelAnimation {
                    OpacityAnimator { duration: 1000}
                    AnchorAnimation { duration: 1000}
                }
            },
            Transition {
                from: "Enter"
                to: "Loading"
                ParallelAnimation {
                    ColorAnimation { from: "lightgreen"; to: "blue"; duration: 1000; loops: Animation.Infinite}
                    AnchorAnimation { duration: 3000}
                }
            },
            Transition {
                from: "Loading"
                to: "Loading done"
                ParallelAnimation {
                    SequentialAnimation {
                        AnchorAnimation { duration: 1000}
                    }
                    OpacityAnimator { target: loadLabel; duration: 100}
                    ColorAnimation { from: "green"; to: "lightgreen"; duration: 1000;}
                }
            },
            Transition {
                from: "Loading"
                to: "Enter"
                ParallelAnimation {
                    SequentialAnimation {
                        AnchorAnimation { duration: 1000}
                    }
                    OpacityAnimator { target: loadLabel; duration: 100}
                    ColorAnimation { from: "green"; to: "lightgreen"; duration: 1000;}
                }
            }
        ]
        Column {
            id:colTwo
            anchors.fill: parent
            padding: 32
            spacing: 32
            BusyIndicator {
                id: busyIndicator
                anchors.horizontalCenter: parent.horizontalCenter
                running: false
            }
            ButLoad {
                id: butLoad
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    thirdFrame.state = "Loading"
                    timer.start()
                }
            }
            Label {
                id: loadLabel
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Loading is done!"
                opacity: 0
            }
        }
        Timer {
            id: timer
            interval: 3000
            repeat: false
            running: false
            onTriggered: {thirdFrame.state = "Loading done"; timer2.start(); butLoad.enabled = false}
        }
        Timer {
            id: timer2
            interval: 1000
            repeat: false
            running: false
            onTriggered: {thirdFrame.state = "Enter"; butLoad.enabled = true}
        }
    }

    ParallelAnimation {
        id: fail
        SequentialAnimation {
            PropertyAnimation {
                targets: [loginTextField, passwordTextField]
                property: "color"
                to: "dark red"
                duration: 0
            }
            PropertyAnimation {
                targets: [loginTextField, passwordTextField]
                property: "color"
                to: secondatyFrame.textColor
                duration: 400
            }
        }
        SequentialAnimation {
            NumberAnimation {
                target: secondatyFrame
                property: "anchors.horizontalCenterOffset"
                to: -10
                duration: 50
            }
            NumberAnimation {
                target: secondatyFrame
                property: "anchors.horizontalCenterOffset"
                to: 10
                duration: 100
            }
            NumberAnimation {
                target: secondatyFrame
                property: "anchors.horizontalCenterOffset"
                to: 0
                duration: 50
            }
        }
        SequentialAnimation {
            ColorAnimation {
                target: root
                to: "dark red"
                property: "color"
                duration: 0
            }
            ColorAnimation {
                target: root
                to: "#e5ecef"
                property: "color"
                duration: 400
            }
        }
    }
}
