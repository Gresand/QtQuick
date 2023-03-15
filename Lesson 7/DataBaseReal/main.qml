import QtQuick 2.15
import QtQuick.Window 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12
import "DBFunction.js" as DbFunctions

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("DB Example")
    property int cellHorizontalSpacing: 10
    property var db
    //Опять возился не понимаю почему такой цвет и вообще так выглядит форма, но я уже столько вопросов задал что мне стыдно, поэтому придется так
    CustomComboBox {
        anchors.bottom: button.top
        height: 50
        width: parent.width
        currentIndex: 2
        model: ListModel {
            id: cbItems
            ListElement { text: "Banana"; color: "Yellow" }
            ListElement { text: "Apple"; color: "Green" }
            ListElement { text: "Coconut"; color: "Brown" }
        }
        onCurrentIndexChanged: console.debug(cbItems.get(currentIndex).text + ", " + cbItems.get(currentIndex).color)
    }

//    TableModel {
//        id: tableModel
//        TableModelColumn { display: "id" }
//        TableModelColumn { display: "first_name" }
//        TableModelColumn { display: "last_name" }
//        TableModelColumn { display: "email" }
//        TableModelColumn { display: "phone" }
//        rows: []
//    }
//    TableView {
//        id: table
//        anchors.fill: parent
//        columnSpacing: 1
//        rowSpacing: 1
//        model: tableModel
//        delegate: Rectangle {
//            implicitWidth: Math.max(100, /*left*/ cellHorizontalSpacing + innerText.width + /*right*/
//                                    cellHorizontalSpacing)
//            implicitHeight: 50
//            border.width: 1
//            Text {
//                id: innerText
//                text: display
//                anchors.centerIn: parent
//            }
//        }
//    }
//    //Кастомный popup с закругленными краями
    RoundPopup {
        id:popup
        anchors.centerIn: parent
        width: 300
        height: 350
        onOpened:  dialog.open()
        Dialog {
            id: dialog
            anchors.centerIn: parent
            title: "Add person"
            standardButtons: Dialog.Ok | Dialog.Cancel
            background: Rectangle {
                anchors.fill: parent
                border.color: "transparent"
            }

            Column {
                anchors.fill: parent
                spacing: 5
                TextField {
                    id: firstName
                    placeholderText: "Имя"
                }
                TextField {
                    id: lastName
                    placeholderText: "Фамилия"
                }
                TextField {
                    id: email
                    placeholderText: "E-mail"
                }
                TextField {
                    id: phone
                    placeholderText: "Номер телефона"
                }
            }
            onAccepted: {
                try {
                    db.transaction((tx) => {
                                       var resObj = DbFunctions.addContact(tx, firstName.text,
                                                                           lastName.text,
                                                                           email.text,
                                                                           phone.text);
                                       if (resObj.rowsAffected !== 0) {
                                           tableModel.appendRow({
                                                                    id: resObj.insertId,
                                                                    first_name: firstName.text,
                                                                    last_name: lastName.text,
                                                                    email: email.text,
                                                                    phone: phone.text
                                                                })
                                       }
                                   })
                } catch (err) {
                    console.log("Error creating or updating table in database: " + err)
                }
            }
            onClosed: popup.close()
        }
    }
    Button {
        id: button
        text: "Добавить человека"
        width: parent.width
        height: 50
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: popup.open()
    }
    Component.onCompleted: {
        db = LocalStorage.openDatabaseSync("DBExample", "1.0", "Пример локальной базы данных", 1000)
        try {
            //Так же не работает, так и не понял как поправить, пытался по-разному
//            DbFunctions.createSimpleTable()
//            db.transaction(DbFunctions.createSimpleTable())
            db.transaction((tx) => { DbFunctions.createSimpleTable() })
        } catch (errCreate) {
            console.log("Error creating or updating table in database: " + errCreate)
        }
        var data_array = ListModel
        try {
            //Не понимаю эту функцию, из-за которой не читается данные, так как при чтении посылается еще модель, а что с ней дальше происходит не знаю
            db.transaction((tx) => { DbFunctions.readContacts(tx, table.model) })
        } catch (err) {
            console.log("Error creating or updating table in database: " + err)
        }
    }
}
