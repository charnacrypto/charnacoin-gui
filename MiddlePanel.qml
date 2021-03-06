// Copyright (c) 2014-2015, The Monero Project
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
// 
// 1. Redistributions of source code must retain the above copyright notice, this list of
//    conditions and the following disclaimer.
// 
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
//    of conditions and the following disclaimer in the documentation and/or other
//    materials provided with the distribution.
// 
// 3. Neither the name of the copyright holder nor the names of its contributors may be
//    used to endorse or promote products derived from this software without specific
//    prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


import QtQml 2.0
import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import moneroComponents.Wallet 1.0

import "./pages"

Rectangle {
    id: root

    property Item currentView
    property Item previousView
    property bool basicMode : false
    property string balanceLabelText: qsTr("Balance") + translationManager.emptyString
    property string balanceText
    property string unlockedBalanceLabelText: qsTr("Unlocked Balance") + translationManager.emptyString
    property string unlockedBalanceText

    property Transfer transferView: Transfer { }
    property Receive receiveView: Receive { }
    property TxKey txkeyView: TxKey { }
    property History historyView: History { }
    property Sign signView: Sign { }
    property Settings settingsView: Settings { }
    property Mining miningView: Mining { }
    property AddressBook addressBookView: AddressBook { }


    signal paymentClicked(string address, string paymentId, string amount, int mixinCount, int priority, string description)
    signal sweepUnmixableClicked()
    signal generatePaymentIdInvoked()
    signal checkPaymentClicked(string address, string txid, string txkey);

    color: "#F0EEEE"

    onCurrentViewChanged: {
        if (previousView) {
            if (typeof previousView.onPageClosed === "function") {
                previousView.onPageClosed();
            }
        }
        previousView = currentView
        if (currentView) {
            stackView.replace(currentView)

            // Component.onCompleted is called before wallet is initilized
            if (typeof currentView.onPageCompleted === "function") {
                currentView.onPageCompleted();
            }
        }
    }

    function updateStatus(){
        transferView.updateStatus();
    }

    // send from AddressBook
    function sendTo(address, paymentId, description){
        root.state = "Transfer";
        transferView.sendTo(address, paymentId, description);
    }


    //   XXX: just for memo, to be removed
    //    states: [
    //        State {
    //            name: "Dashboard"
    //            PropertyChanges { target: loader; source: "pages/Dashboard.qml" }
    //        }, State {
    //            name: "History"
    //            PropertyChanges { target: loader; source: "pages/History.qml" }
    //        }, State {
    //            name: "Transfer"
    //            PropertyChanges { target: loader; source: "pages/Transfer.qml" }
    //        }, State {
    //           name: "Receive"
    //           PropertyChanges { target: loader; source: "pages/Receive.qml" }
    //        }, State {
    //            name: "AddressBook"
    //            PropertyChanges { target: loader; source: "pages/AddressBook.qml" }
    //        }, State {
    //            name: "Settings"
    //            PropertyChanges { target: loader; source: "pages/Settings.qml" }
    //        }, State {
    //            name: "Mining"
    //            PropertyChanges { target: loader; source: "pages/Mining.qml" }
    //        }
    //    ]

        states: [
            State {
                name: "Dashboard"
                PropertyChanges {  }
            }, State {
                name: "History"
                PropertyChanges { target: root; currentView: historyView }
                PropertyChanges { target: historyView; model: appWindow.currentWallet ? appWindow.currentWallet.historyModel : null }
            }, State {
                name: "Transfer"
                PropertyChanges { target: root; currentView: transferView }
            }, State {
               name: "Receive"
               PropertyChanges { target: root; currentView: receiveView }
            }, State {
               name: "TxKey"
               PropertyChanges { target: root; currentView: txkeyView }
            }, State {
                name: "AddressBook"
                PropertyChanges {  target: root; currentView: addressBookView  }
            }, State {
                name: "Sign"
               PropertyChanges { target: root; currentView: signView }
            }, State {
                name: "Settings"
               PropertyChanges { target: root; currentView: settingsView }
            }, State {
                name: "Mining"
                PropertyChanges { target: root; currentView: miningView }
            }
        ]

    // color stripe at the top
    Row {
        id: styledRow
        height: 4
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right


        Rectangle { height: 4; width: parent.width / 5; color: "#FFE00A" }
        Rectangle { height: 4; width: parent.width / 5; color: "#6B0072" }
        Rectangle { height: 4; width: parent.width / 5; color: "#FCB819" }
        Rectangle { height: 4; width: parent.width / 5; color: "#FFD781" }
        Rectangle { height: 4; width: parent.width / 5; color: "#FF4F41" }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 2
        anchors.topMargin: appWindow.persistentSettings.customDecorations ? 30 : 0
        spacing: 0


        // BasicPanel header
        Rectangle {
            id: header
            anchors.leftMargin: 1
            anchors.rightMargin: 1
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color: "#FFFFFF"
            visible: basicMode

            Image {
                id: logo
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -5
                anchors.left: parent.left
                anchors.leftMargin: appWindow.persistentSettings.customDecorations ? 20 : 40
                source: "images/charnacoinLogo2.png"
            }

            Grid {
                anchors.verticalCenter: parent.verticalCenter
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 10
                width: 256
                columns: 3

                Text {
                    id: balanceLabel
                    width: 116
                    height: 20
                    font.family: "Arial"
                    font.pixelSize: 12
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    color: "#535353"
                    text: root.balanceLabelText + ":"
                }

                Text {
                    id: balanceText
                    width: 110
                    height: 20
                    font.family: "Arial"
                    font.pixelSize: 18
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    color: "#0F0101"
                    text: root.balanceText
                }

                Item {
                    height: 20
                    width: 20

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        source: "images/lockIcon.png"
                    }
                }

                Text {
                    id: availableBalanceLabel
                    width: 116
                    height: 20
                    font.family: "Arial"
                    font.pixelSize: 12
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    color: "#535353"
                    text: root.unlockedBalanceLabelText + ":"
                }

                Text {
                    id: availableBalanceText
                    width: 110
                    height: 20
                    font.family: "Arial"
                    font.pixelSize: 14
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    color: "#0F0101"
                    text: root.unlockedBalanceText
                }
            }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: "#DBDBDB"
            }
        }

        // Views container
        StackView {
            id: stackView
            initialItem: transferView
            anchors.topMargin: 30
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.margins: 4
            clip: true // otherwise animation will affect left panel

            delegate: StackViewDelegate {
                pushTransition: StackViewTransition {
                    PropertyAnimation {
                        target: enterItem
                        property: "x"
                        from: 0 - target.width
                        to: 0
                        duration: 300
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "x"
                        from: 0
                        to: target.width
                        duration: 300
                    }
                }
            }
        }
    }
    // border
    Rectangle {
        anchors.top: styledRow.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 1
        color: "#DBDBDB"
    }

    Rectangle {
        anchors.top: styledRow.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 1
        color: "#DBDBDB"
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
        color: "#DBDBDB"

    }

    /* connect "payment" click */
    Connections {
        ignoreUnknownSignals: false
        target: transferView
        onPaymentClicked : {
            console.log("MiddlePanel: paymentClicked")
            paymentClicked(address, paymentId, amount, mixinCount, priority, description)
        }
        onSweepUnmixableClicked : {
            console.log("MiddlePanel: sweepUnmixableClicked")
            sweepUnmixableClicked()
        }
    }
}
