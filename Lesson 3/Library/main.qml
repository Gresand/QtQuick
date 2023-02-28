import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Books")

    ListModel {
        id: books
        ListElement {
            path: "/"
            name: "Book"
            genre: "Horror"
            author: "I'm"
        }
        ListElement {
            path: "/"
            name: "Book1"
            genre: "Boevik"
            author: "Me too"
        }
        ListElement {
            path: "/"
            name: "Book2"
            genre: "Horror"
            author: "And me too"
        }
    }

    ListView {
        id: list
        anchors.fill: parent
        model: books
        spacing: 2
        header: Rectangle {
            width: parent.width
            height: 20
            color: "darkblue"
            Text {
                anchors.centerIn: parent
                text: "Library"
                color: "white"
            }
        }
        footer: Rectangle {
            width: parent.width
            height: 20
            color: "darkgreen"
            Text {
                anchors.centerIn: parent
                text: "Designed by Gres"
                color: "White"
            }
        }
        section.delegate: Rectangle {
            width: parent.width
            height: 20
            color: "lightblue"
            Text {
                anchors.centerIn: parent
                text: section
                color: "darkblue"
                font.weight: Font.Bold
            }
        }
        section.property: "genre"
        delegate: Rectangle {
            width: parent.width
            height: 60
            radius: 3
            border.width: 1
            border.color: "darkgrey"
            color: "lightgrey"
            Column {
                anchors.fill: parent
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text { text: "Путь к иконке"; font.weight: Font.Bold }
                    Text { text: path}
                    spacing: 20
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text { text: "Название книги"; font.weight: Font.Bold }
                    Text { text: name}
                    spacing: 20
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text { text: "Жанр"; font.weight: Font.Bold }
                    Text { text: genre}
                    spacing: 20
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text { text: "Автор"; font.weight: Font.Bold }
                    Text { text: author}
                    spacing: 20
                }
            }
        }
    }
}
