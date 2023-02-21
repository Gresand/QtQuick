import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    /*
    Параметры для поиска партнера(ProgressBar):
    */

    StackView {
        id: stack
        initialItem: page1
        anchors.fill: parent
        anchors.centerIn: parent
        clip: true
        pushEnter: Transition {
            PropertyAnimation { property: "opacity"; from: 0; to:1; duration: 200 }
        }
        pushExit: Transition {
            PropertyAnimation { property: "opacity"; from: 1; to:0; duration: 200 }
        }
        popEnter: Transition {
            PropertyAnimation { property: "opacity"; from: 0; to:1; duration: 200 }
        }
        popExit: Transition {
            PropertyAnimation { property: "opacity"; from: 1; to:0; duration: 200 }
        }

        Page {
            id:page1
            Rectangle {
                width: parent.width
                height: parent.height
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "red" }
                    GradientStop { position: 1.0; color: "pink" }
                }
            }

            Column {
                anchors.fill: parent
                anchors.centerIn: parent
                clip: true
                padding: 20
                spacing: 10

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Приветствуем вас в приложении для поиска второй половинки"
                    wrapMode: Text.WordWrap
                }

                TextField {
                    id:name
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText: "Ваше имя"
                    width: 200
                    background: Rectangle {
                        color: "transparent"
                        border.color: parent.hovered ? "dark red" : " black"
                    }
                }

                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    RadioButton {
                        id: man
                        checked: true
                        text: "Мужской"
                    }
                    RadioButton {
                        id: women
                        text: "Женский"
                    }
                }

                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 300
                    Layout.fillWidth: true

                    Label {
                        text: "Ваш возраст: " + slide.value
                    }

                    Slider {
                        id: slide
                        stepSize: 1
                        from: 18
                        to: 100
                    }
                }

                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 300
                    Label {
                        width: parent / 2
                        text: "Образование: "
                    }

                    ComboBox {
                        id: combo
                        model: ["Среднее", "Средне-специальное", "Высшее", "Церковно-приходская школа"]
                        Layout.fillWidth: true
                        background: Rectangle {
                                color: "transparent"
                                border.color: parent.hovered ? "dark red" : " black"
                            }
                        }
                    }


                TextField {
                    id: town
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText: "Город"
                    width: 200
                    background: Rectangle {
                            color: "transparent"
                            border.color: parent.hovered ? "dark red" : " black"
                    }
                }

                TextArea {
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText: "Расскажите о своём хобби"
                    width: 300
                    wrapMode: TextEdit.Wrap
                    background: Rectangle {
                            color: "transparent"
                            border.color: parent.hovered ? "dark red" : " black"
                        }
                }

                TextArea {
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText: "Расскажите о себе"
                    width: 300
                    wrapMode: TextEdit.Wrap
                    background: Rectangle {
                            color: "transparent"
                            border.color: parent.hovered ? "dark red" : " black"
                        }
                }
            }
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                text: "Поиск"
                height: 40
                width: 100
                onClicked: { stack.push(page2); page2.visible = true }
                background: Rectangle {
                    color: parent.pressed ? "pink" : (parent.hovered ? "red" : "transparent")
                    border.color: " black"
                }
            }
        }

        Page {
            id:page2
            visible: false
            Rectangle {
                width: parent.width
                height: parent.height
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "pink" }
                    GradientStop { position: 1.0; color: "red" }
                }
            }
            Column {
                anchors.fill: parent
                clip: true
                padding: 20
                spacing: 10

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Выберите предпочтение"
                    wrapMode: Text.WordWrap
                }

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Ищем " + (man.checked ? "женщину" : "мужчину")
                    wrapMode: Text.WordWrap
                }

                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Label {
                        text: "Возраст от: " + parseInt(findAge.first.value) + " до: " + parseInt(findAge.second.value)
                        wrapMode: Text.WordWrap
                    }

                    RangeSlider {
                        id:findAge
                        from: 18
                        to: 100
                        stepSize: 1
                        first.value: 18
                        second.value: 55
                    }

                }

                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 300
                    Label {
                        width: parent / 2
                        text: "Образование: "
                    }

                    ComboBox {
                        id: comboP
                        model: ["Среднее", "Средне-специальное", "Высшее", "Церковно-приходская школа"]
                        Layout.fillWidth: true
                        background: Rectangle {
                                color: "transparent"
                                border.color: parent.hovered ? "dark red" : " black"
                            }
                        }
                    }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Регистрация"
                    height: 40
                    width: 100
                    onClicked: {
                        console.log("Проверьте данные:\nВас зовут " + name.text + ", ваш пол: " + (man.checked ? "мужской" : "женский") + " возраст: " +
                                    slide.value + " лет" + ", образование " + combo.currentText + ", из города: " + town.text +
                                    "\nВы ищете" + (man.checked ? " женщину" : " мужчину")  +
                                    ", возрастом от " + parseInt(findAge.first.value) + " до " + parseInt(findAge.second.value) +
                                    ", образование: " + comboP.currentText)
                    }
                    background: Rectangle {
                        color: parent.pressed ? "pink" : (parent.hovered ? "red" : "transparent")
                        border.color: " black"
                    }
                }
            }
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                height: 40
                width: 100
                text: "Назад"
                onClicked: stack.pop(page1)
                background: Rectangle {
                    color: parent.pressed ? "red" : (parent.hovered ? "pink" : "transparent")
                    border.color: " black"
                }
            }
        }
    }
}
