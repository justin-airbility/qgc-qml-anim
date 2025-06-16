import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    property real angle: 0

    width: 60
    height: 150

    Rectangle {
        anchors.centerIn: parent
        width: 10
        height: 80
        color: "gray"
        transform: Rotation {
            origin.x: 5
            origin.y: 0
            angle: root.angle
        }
    }

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: Math.round(angle) + "°"
        font.pointSize: 10
        color: "white"
    }
}
