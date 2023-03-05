import QtQuick 2.12
import QtQuick.Controls 2.15
import "FunctionDynamicLoad.js" as FDL

Item {
    anchors.fill: parent
    id: primaryFrame
    property string login: "user"
    property string password: "123"

    signal createSecondPage()

    function checkCredentials() {
        if (login === loginTextField.text
                && password === passwordTextField.text) {
            primaryFrame.state = "destroy"

            //В своё оправдание скажу что я ну дня три мучался и пытался следать удаление в анимации, но у меня не работает ни onFinished ни onStopped
            var timer = Qt.createQmlObject('import QtQuick 2.0; Timer { interval: 1500; onTriggered: { primaryFrame.destroy(); } }', primaryFrame)
                   timer.start()
        }
        else
            failAnimation.start()
    }
    state: "destroy"
    states:[
        State {
            name: "destroy"
            PropertyChanges {target:loginTextField;opacity: 0}
            PropertyChanges {target:loginTextField;enabled: false}
            PropertyChanges {target:passwordTextField;opacity: 0}
            PropertyChanges {target:passwordTextField;enabled: false}
            PropertyChanges {target:submitButton;opacity: 0}
            PropertyChanges {target:submitButton;enabled: false}
            PropertyChanges {target:secondaryFrame;opacity: 0}
            PropertyChanges { target: primaryFrame; scale: 0 }
        },
        State {
            name: "visible"
            PropertyChanges {target:loginTextField;opacity: 1}
            PropertyChanges {target:loginTextField;enabled: true}
            PropertyChanges {target:passwordTextField;opacity: 1}
            PropertyChanges {target:passwordTextField;enabled: true}
            PropertyChanges {target:submitButton;opacity: 1}
            PropertyChanges {target:submitButton;enabled: true}
            PropertyChanges {target:secondaryFrame;opacity: 1}
            PropertyChanges { target: primaryFrame; scale: 1}
        }
    ]

    transitions: [Transition {
            from: "visible"
            to: "destroy"
            SequentialAnimation {
                PropertyAnimation {
                    targets: [loginTextField,passwordTextField,submitButton]
                    property: "opacity"
                    duration: 300
                }
                PropertyAnimation {
                    target: secondaryFrame
                    property: "opacity"
                    duration: 300
                }
                PropertyAnimation {
                    target: primaryFrame
                    property: "scale"
                    duration: 300
                }
            }
        },
        Transition {
            to: "visible"
            SequentialAnimation {
                PropertyAnimation {
                    target: primaryFrame
                    property: "scale"
                    duration: 300
                }
                PropertyAnimation {
                    target: secondaryFrame
                    property: "opacity"
                    duration: 300
                }
                PropertyAnimation {
                    targets: [loginTextField,passwordTextField,submitButton]
                    property: "opacity"
                    duration: 300
                }
            }
        }
    ]

    Component.onCompleted: primaryFrame.state = "visible";
    Component.onDestruction: {
        FDL.createSpriteObjects("PageTwo",spriteContainer);
    }

    Rectangle { anchors.fill: parent; color: "#e5ecef" }

    Rectangle {
        id: secondaryFrame
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

            TextField {
                id: loginTextField
                anchors.horizontalCenter: parent.horizontalCenter // размещение

                placeholderText: qsTr("Логин")
                color: secondaryFrame.textColor
                Keys.onEnterPressed: checkCredentials()
                Keys.onReturnPressed: checkCredentials()
            }

            TextField {
                id: passwordTextField
                echoMode: TextInput.Password // звездочки вместо пароля
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Пароль")
                color: secondaryFrame.textColor
                Keys.onEnterPressed: checkCredentials()
                Keys.onReturnPressed: checkCredentials()
            }

            Button {
                id: submitButton
                width: 200
                height: 40
                background: Rectangle {
                    color: parent.down ? "#bbbbbb" :
                                         (parent.hovered ? "#d6d6d6" : "#f6f6f6")
                }
                text: qsTr("Вход")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: checkCredentials()
            }
        }
    }

    ParallelAnimation{
        id: failAnimation
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
                to: secondaryFrame.textColor
                duration: 400
            }
        }

        SequentialAnimation {
            NumberAnimation { target: secondaryFrame; property:
                    "anchors.horizontalCenterOffset"; to: -5; duration: 50 }
            NumberAnimation { target: secondaryFrame; property:
                    "anchors.horizontalCenterOffset"; to: 5; duration: 100 }
            NumberAnimation { target: secondaryFrame; property:
                    "anchors.horizontalCenterOffset"; to: 0; duration: 50 }
        }
    }
}
