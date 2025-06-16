import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    width: 600
    height: 400

    // Simulate 4 tilt angles (0-90 degrees)
    property real tilt1: 0
    property real tilt2: 20
    property real tilt3: 45
    property real tilt4: 70

    // Optional: Animate values with a timer
    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            tilt1 = (tilt1 + 1) % 91
            tilt2 = (tilt2 + 1.5) % 91
            tilt3 = (tilt3 + 2) % 91
            tilt4 = (tilt4 + 2.5) % 91
        }
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: 40

        Repeater {
            model: 4
            delegate: TiltrotorVisual {
                angle: model.index === 0 ? tilt1
                      : model.index === 1 ? tilt2
                      : model.index === 2 ? tilt3
                      : tilt4
            }
        }
    }
}
