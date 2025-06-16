import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 800
    height: 1000
    title: "Nacelle Layout with Fuselage Overlay"

    property var angleSteps: [0, 45, 90]

    Column {
        anchors.centerIn: parent
        spacing: 30

        Item {
            width: 800
            height: 500

            // Static Fuselage Image
            Image {
                id: fuselage
                source: "file:C:/Users/Minyoung_SIM/Documents/nacelles/images/fuselage.png"
                anchors.centerIn: parent
                width: 500
                height: 300
                fillMode: Image.PreserveAspectFit
                z: 0
            }

            // Top-Left Nacelle (FL)
            Column {
                spacing: 5
                // anchors.horizontalCenter: parent.left
                // anchors.top: parent.top
                // anchors.margins: 40
                x: 300
                y: 80
                z: 1

                Text {
                    text: nacelle1Slider.value + "°"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                }

                Image {
                    source: "file:C:/Users/Minyoung_SIM/Documents/nacelles/images/" + nacelle1Slider.value + ".png"
                    width: 80
                    height: 80
                    fillMode: Image.PreserveAspectFit
                }
            }

            // Top-Right Nacelle (FR)
            Column {
                spacing: 5
                x: 500
                y: 80
                z: 1

                Text {
                    text: nacelle2Slider.value + "°"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                }

                Image {
                    source: "file:C:/Users/Minyoung_SIM/Documents/nacelles/images/" + nacelle2Slider.value + ".png"
                    width: 80
                    height: 80
                    fillMode: Image.PreserveAspectFit
                    transform: Scale { xScale: -1; yScale: 1 }  // flip horizontally
                }
            }

            // Bottom-Left Nacelle (RL)
            Column {
                spacing: 5
                x: 300
                y: 260
                z: 1

                Text {
                    text: nacelle3Slider.value + "°"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                }

                Image {
                    source: "file:C:/Users/Minyoung_SIM/Documents/nacelles/images/" + nacelle3Slider.value + ".png"
                    width: 80
                    height: 80
                    fillMode: Image.PreserveAspectFit
                }
            }

            // Bottom-Right Nacelle (RR)
            Column {
                spacing: 5
                x: 500
                y: 260
                z: 1

                Text {
                    text: nacelle4Slider.value + "°"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                }

                Image {
                    source: "file:C:/Users/Minyoung_SIM/Documents/nacelles/images/" + nacelle4Slider.value + ".png"
                    width: 80
                    height: 80
                    fillMode: Image.PreserveAspectFit
                    transform: Scale { xScale: -1; yScale: 1 }  // flip horizontally
                }
            }
        }

        // Sliders for Testing
        Column {
            spacing: 12

            Slider { id: nacelle1Slider; from: 0; to: 90; stepSize: 45; value: 0 }
            Slider { id: nacelle2Slider; from: 0; to: 90; stepSize: 45; value: 45 }
            Slider { id: nacelle3Slider; from: 0; to: 90; stepSize: 45; value: 45 }
            Slider { id: nacelle4Slider; from: 0; to: 90; stepSize: 45; value: 90 }
        }
    }
}
