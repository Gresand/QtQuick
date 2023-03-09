import QtQuick 2.12
import QtQuick.XmlListModel 2.12

Rectangle {
    width: 400
    height: 200
    color: "lightblue"

    Text {
        id: temperature
        anchors.centerIn: parent
        text: "Температура:"
        font.pointSize: 24
    }

    Component.onCompleted: {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "https://api.gismeteo.ru/v2/weather/current/?city=Москва", true); // Температура в Москве
        xhr.setRequestHeader("X-Gismeteo-Token", "56b30cb255.3443075");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    temperature.text = "Температура: " + response.fact.temp + "°C";
                } else {
                    console.log("Ошибка получения погодных данных");
                }
            }
        };
        xhr.send();
    }
}
