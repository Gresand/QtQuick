var component
var sprite

function createSpriteObjects(componentURL) {
    component = Qt.createComponent(componentURL+".qml");
    if (component.status == Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation);
}
function finishCreation() {
    if (component.status == Component.Ready) {
        sprite = component.createObject(spriteContainer);
        if (sprite == null) {
            console.log("Error creating object");
        }
    } else if (component.status == Component.Error) {
        console.log("Error loading component:", component.errorString());
    }
}
