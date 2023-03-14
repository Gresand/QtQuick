import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Data list")

    function getFriends(friends) {
        var resString = ""
        for (const friend of friends)
            resString += friend + ", "
        return resString
    }
    ListView {
        anchors.fill: parent
        model: mdl
        spacing: 2
        delegate: SwipeView {
            width: parent.width
            height: 50
            spacing: 2
            Row {
                width: 270
                height: 50
                spacing: 2
                Rectangle {
                    width: parent.width / 3
                    height: parent.height
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        text: rowid
                    }
                }
                Rectangle {
                    width: parent.width / 3
                    height: parent.height
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        text: name
                    }
                }
                Rectangle {
                    width: parent.width / 3
                    height: parent.height
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        text: surname
                    }
                }
            }
            Rectangle {
                height: parent.height
                border.width: 1
                Text {
                    anchors.fill: parent
                    text: getFriends(friends)
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
        header: SwipeView {
            width: parent.width
            height: 50
            Row {
                anchors.margins: 10
                height: 50
                spacing: 2
                Rectangle {
                    width: parent.width / 3
                    height: parent.height
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        text: "rowid"
                    }
                }
                Rectangle {
                    width: parent.width / 3
                    height: parent.height
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        text: "name"
                    }
                }
                Rectangle {
                    width: parent.width / 3
                    height: parent.height
                    border.width: 1
                    Text {
                        anchors.centerIn: parent
                        text: "surname"
                    }
                }
            }
            Rectangle {
                height: parent.height
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    text: "friends"
                }
            }
        }
    }
}
