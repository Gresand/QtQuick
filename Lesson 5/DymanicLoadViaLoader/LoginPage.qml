import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id:loginPage
    width: parent.width
    height: parent.height
    color: "#f0f0f0"

    signal onLoggedIn()

    function login() {
        if(userName.text === "login" && password.text === "password")
        {
            onLoggedIn()
            loginPage.destroy()
        }
    }

    state: "destroy"
    states:[
        State {
            name: "destroy"
            PropertyChanges {target:userName;opacity: 0}
            PropertyChanges {target:userName;enabled: false}
            PropertyChanges {target:password;opacity: 0}
            PropertyChanges {target:password;enabled: false}
            PropertyChanges {target:butAut;opacity: 0}
            PropertyChanges {target:butAut;enabled: false}
            PropertyChanges {target:secondaryFrame;opacity: 0}
        },
        State {
            name: "visible"
            PropertyChanges {target:userName;opacity: 1}
            PropertyChanges {target:userName;enabled: true}
            PropertyChanges {target:password;opacity: 1}
            PropertyChanges {target:password;enabled: true}
            PropertyChanges {target:butAut;opacity: 1}
            PropertyChanges {target:butAut;enabled: true}
            PropertyChanges {target:secondaryFrame;opacity: 1}
        }
    ]

    transitions: [Transition {
            from: "visible"
            to: "destroy"
            SequentialAnimation {
                PropertyAnimation {
                    targets: [userName,password,butAut]
                    property: "opacity"
                    duration: 300
                }
                PropertyAnimation {
                    target: secondaryFrame
                    property: "opacity"
                    duration: 300
                }
            }
        },
        Transition {
            to: "visible"
            SequentialAnimation {
                PropertyAnimation {
                    target: secondaryFrame
                    property: "opacity"
                    duration: 300
                }
                PropertyAnimation {
                    targets: [userName,password,butAut]
                    property: "opacity"
                    duration: 300
                }
            }
        }
    ]
    Component.onCompleted: {
        console.log("Login Page completed")
        loginPage.state = "visible"
    }
//    Component.onDestroyed: console.log("Login Page destroyed") Почему-то с этой строчкой вылезает ошибка загрузки и нет возможности проверить удаляется ли компонент
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
                id:userName
                placeholderText: "Login"
                anchors.topMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter // размещение
                color: secondaryFrame.textColor
            }
            TextField {
                id: password
                placeholderText: "Password"
                echoMode: TextInput.Password
                anchors.horizontalCenter: parent.horizontalCenter
                color: secondaryFrame.textColor
                anchors.topMargin: 5
            }
            Button {
                id: butAut
                text: "Enter"
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                width: 200
                height: 40
                background: Rectangle {
                    color: parent.down ? "#bbbbbb" :
                                         (parent.hovered ? "#d6d6d6" : "#f6f6f6")
                }
                onClicked: {
                    if(userName.text === "login" && password.text === "password") {
                       login()
                    }
                    else {
                        failAnimation.start()
                    }
                }
            }
        }
    }

    ParallelAnimation{
        id: failAnimation
        SequentialAnimation {

            PropertyAnimation {
                targets: [userName, password]
                property: "color"
                to: "dark red"
                duration: 0
            }

            PropertyAnimation {
                targets: [userName, password]
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
