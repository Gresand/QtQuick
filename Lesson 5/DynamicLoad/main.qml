import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

import "FunctionDynamicLoad.js" as FDL

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    id: parentWindow
    property string pageEnter: "PageEnter"
    property string pageTwo: "PageTwo"
    signal createSecondPage()

    //Пытался сделать через коннекты
//    Connections {
//        target: primaryFrame
//        onCreateSecondPage: {
//            primaryFrame.destroy()
//            FDL.createSpriteObjects("PageTwo",spriteContainer);
//        }
//    }

    Item {
        id: spriteContainer
        anchors.fill: parent
    }
    Component.onCompleted: FDL.createSpriteObjects("PageEnter",spriteContainer);
}
