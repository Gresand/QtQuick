import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQuick.XmlListModel 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Rest API")

    XmlListModel {
        id: xmlModel
        source: "https://world.openfoodfacts.org/api/v0/product/{product_id}.json"
        query: "/product"

        XmlRole { name: "product_name"; query: "product_name" }
        XmlRole { name: "image_url"; query: "image_url" }

        property string product_id: "barcode_number"
        property string barcode_number: ""

        onBarcode_numberChanged: {
            xmlModel.source = "https://world.openfoodfacts.org/api/v0/product/" + barcode_number + ".json"
            xmlModel.reload()
        }
    }

    ListView {
        id: listView
        width: parent.width
        height: parent.height
        model: xmlModel
        delegate: Item {
            width: parent.width
            height: 100
            RowLayout {
                Image {
                    width: 50
                    height: 50
                    source: image_url
                }
                Text {
                    text: product_name
                }
            }
        }
    }

    Rectangle {
        id: form
        width: parent.width
        height: 50
        RowLayout {
            TextField {
                id: barcodeNumberField
                width: 200
                placeholderText: "Введите идентификатор продукта"
                onTextChanged: xmlModel.barcode_number = text
            }
            Button {
                text: "Поиск"
                onClicked: xmlModel.reload()
            }
        }
    }
}
