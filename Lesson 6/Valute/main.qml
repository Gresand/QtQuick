import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Rectangle {
    width: 640
    height: 480
    color: "#333333"
    visible: true

    property string token: "SFR8sCEwMI7yeznlSPNF9x0hlOf5yl0H"
    property var xmlData
    property bool success: false

    function loadData() {
        currencyModel.status = "loading";
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
//                    currencyModel.clear(); Почему-то не работает
                    var response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        for (var key in response.rates) {
                            currencyModel.append({ "currency": key, "rate": response.rates[key] });
                        }
                        currencyModel.status = "success";
                        console.log("Data loaded successfully.");
                    } else {
                        currencyModel.status = "error";
                        console.log("Failed to load data from API: " + response.error.info);
                    }
                } else {
                    currencyModel.status = "error";
                    console.log("Failed to load data from API. Status code: " + xhr.status);
                }
            }
        }
        var url = "http://data.fixer.io/api/latest?access_key=" + token + "&format=1";
        xhr.open("GET", url);
        xhr.send();
    }



    function updateModel() {
        if (success) {
            currencyModel.source = xmlData;
        } else {
            console.log("Failed to load data from API");
        }
    }

    XmlListModel {
        id: currencyModel
        property string status: "initial"
        source: ""
        query: "/query/results/rate"
        XmlRole { name: "currency"; query: "attribute::currency" }
        XmlRole { name: "rate"; query: "attribute::rate" }
    }

    Component {
        id: currencyDelegate
        Text {
            text: currency + ": " + rate
            color: "white"
            font.pointSize: 18
        }
    }

    ListView {
        id: currencyListView
        anchors.fill: parent
        model: currencyModel
        delegate: currencyDelegate
        onModelChanged: {
            console.log("Model changed");
            updateModel();
        }
    }

    Component.onCompleted: {
        console.log("Loading data...");
        loadData();
    }
}
