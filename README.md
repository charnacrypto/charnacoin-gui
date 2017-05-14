# Charnacoin GUI

Copyright (c) 2017, The Charnacoin Project

## Development Resources

- Web: [charnacoin.com](https://charnacoin.com)
- Mail: [crypto@charnacoin.com](mailto:crypto@charnacoin.com)
- Github: [https://github.com/charnacrypto/charnacoin-gui](https://github.com/charnacrypto/charnacoin-gui)
- IRC: [#charnacoin-dev on Freenode](irc://chat.freenode.net/#charnacoin-dev)

## Introduction

As Cryptonote/Monero based technology, Charnacoin is a private, secure, untraceable, decentralised digital currency. You are your bank, you control your funds, and nobody can trace your transfers unless you allow them to do so.

**Privacy:** Charnacoin uses a cryptographically sound system to allow you to send and receive funds without your transactions being easily revealed on the blockchain (the ledger of transactions that everyone has). This ensures that your purchases, receipts, and all transfers remain absolutely private by default.

**Security:** Using the power of a distributed peer-to-peer consensus network, every transaction on the network is cryptographically secured. Individual wallets have a 25 word mnemonic seed that is only displayed once, and can be written down to backup the wallet. Wallet files are encrypted with a passphrase to ensure they are useless if stolen.

**Untraceability:** By taking advantage of ring signatures, a special property of a certain type of cryptography, Charnacoin is able to ensure that transactions are not only untraceable, but have an optional measure of ambiguity that ensures that transactions cannot easily be tied back to an individual user or computer.

## About this Project

This is the GUI for the [core Charnacoin implementation](https://github.com/charnacrypto/charnacoin). It is open source and completely free to use without restrictions, except for those specified in the license agreement below. There are no restrictions on anyone creating an alternative implementation of Charnacoin that uses the protocol and network in a compatible manner.

As with many development projects, the repository on Github is considered to be the "staging" area for the latest changes. Before changes are merged into that branch on the main repository, they are tested by individual developers in their own branches, submitted as a pull request, and then subsequently tested by contributors who focus on testing and code reviews. Monero's development is also well followed to sweet futur improvements according to charnacoin own behavior. That having been said, the repository should be carefully considered before using it in a production environment, unless there is a patch in the repository for a particular show-stopping issue you are experiencing. It is generally a better idea to use a tagged release for stability.

## Supporting the Project

Charnacoin development can be supported directly through donations.

Both Charnacoin and Bitcoin donations can be made to charnacoin.com/donate.

The Charnacoin donation address is: `Cjo7trECi42f2Ph7BJtxc5e2fGtmpVkXLYyE5ynhnnf41p4n9oN3zn696muBZX6CBca8q1c46T5H8ZSKhLHtR2MGCrjLyoZ` (viewkey: ` `)

The Bitcoin donation address is: `131BRfZ1rmPApxo2GWiY8GwAodotXy5hCF`

## License

See [LICENSE](LICENSE).

## Installing Charnacoin Core from a Package

Packaging for your favorite distribution would be a welcome contribution!

## Compiling Charnacoin Core from Source

### On Linux:

(Tested on Ubuntu 16.04 x86, 16.10 x64 and Linux Mint 18 "Sarah" - Cinnamon x64)

1. Install Charnacoin dependencies.

	`sudo apt install build-essential cmake libboost-all-dev miniupnpc libunbound-dev graphviz doxygen libunwind8-dev pkg-config libssl-dev`

2. Grab an up-to-date copy of the charnacoin-gui repository.

	`git clone https://github.com/charnacrypto/charnacoin-gui.git`

3. Go into the repository.

	`cd charnacoin`

4. Use the script to compile the Charnacoin libs necessary to run the GUI.

	`./get_libwallet_api.sh`


5. Install the GUI dependencies.

  - For Ubuntu 16.04 x86

	`sudo apt-get install qtbase5-dev qt5-default qtdeclarative5-dev qml-module-qtquick-controls qml-module-qtquick-xmllistmodel qttools5-dev-tools qml-module-qtquick-dialogs`

  - For Ubuntu 16.04+ x64

     `sudo apt-get install qtbase5-dev qt5-default qtdeclarative5-dev qml-module-qtquick-controls qml-module-qtquick-xmllistmodel qttools5-dev-tools qml-module-qtquick-dialogs qml-module-qt-labs-settings libqt5qml-graphicaleffects`

  - For Linux Mint 18 "Sarah" - Cinnamon x64

     `sudo apt install qml-module-qt-labs-settings qml-module-qtgraphicaleffects`

  - Optional : To build the flag `WITH_SCANNER`

     `sudo apt install qtmultimedia5-dev qml-module-qtmultimedia libzbar-dev`

6. Build the GUI.

	`./build.sh`

7. Run the GUI client.

	`./build/release/bin/charnacoin-wallet-gui`

### On OS X:

1. Install Xcode from AppStore
2. Install [homebrew](http://brew.sh/)
3. Install [charnacoin](https://github.com/charnacrypto/charnacoin) dependencies:

  `brew install boost --c++11`

  `brew install openssl` - to install openssl headers

  `brew install pkgconfig`

  `brew install cmake`

  `brew install qt5`  (or download QT 5.8+ from [qt.io](https://www.qt.io/download-open-source/))

  If you have an older version of Qt installed via homebrew, you can force it to use 5.x like so:
  
  `brew link --force --overwrite qt5`

4. Install latest Qt using official installer from [qt.io](https://www.qt.io/download-open-source/) (homebrew version might be outdated).
5. Add Qt bin dir to your path (check first if directory exists; 5.8 is the current version)

    `export PATH=$PATH:$HOME/Qt/5.8/clang_64/bin`

5. Add Qt bin dir to your path.  Example:

    `export PATH=$PATH:/usr/local/opt/qt5/bin`

    make sure this is where Qt 5.x is installed on **your** system eg `$HOME/Qt/5.8/clang_64/bin` if you downloaded from qt.io.

6. Grab an up-to-date copy of the charnacoin-gui repository.

  `git clone https://github.com/charnacrypto/charnacoin-gui.git`

7. Go into the repository.

  `cd charnacoin`

8. Build libwallet

  `./get_libwallet_api.sh`

9. Start the build:

  `./build.sh`

The executable can be found in the `build/release/bin` folder.

**Note:** Workaround for "ERROR: Xcode not set up properly"

Edit `$HOME/Qt/5.7/clang_64/mkspecs/features/mac/default_pre.prf`

replace
`isEmpty($$list($$system("/usr/bin/xcrun -find xcrun 2>/dev/null")))`

with
`isEmpty($$list($$system("/usr/bin/xcrun -find xcodebuild 2>/dev/null")))`

More info: http://stackoverflow.com/a/35098040/1683164


### On Windows:

1. Install [msys2](http://msys2.github.io/), follow the instructions on that page on how to update packages to the latest versions

2. Install charnacoin dependencies as described in [charnacoin documentation](https://github.com/charnacrypto/charnacoin) into msys2 environment.
   **As we only build application for x86, install only dependencies for x86 architecture (i686 in package name)**
   ```
   pacman -S mingw-w64-i686-toolchain make mingw-w64-i686-cmake mingw-w64-i686-boost

   ```

3. Install git into msys2 environment:

    ```
    pacman -S git
    ```

4. Install Qt5 from [official site](https://www.qt.io/download-open-source/).
   - download unified installer, run and select following options:
       - Qt > Qt 5.7 > MinGW 5.3.0 32 bit
       - Tools > MinGW 5.3.0
   - continue with installation

5. Open ```MinGW-w64 Win32 Shell``` shell:

   ```%MSYS_ROOT%\msys2_shell.cmd -mingw32```

   Where ```%MSYS_ROOT%``` will be ```c:\msys32``` if your host OS is x86-based or ```c:\msys64``` if your host OS
   is x64-based

6. Install the latest version of boost, specificly the required static libraries:
    ```
    cd
    wget http://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.bz2
    tar xjf boost_1_63_0.tar.bz2
    cd boost_1_63_0
    ./bootstrap.sh mingw
    ./b2 --prefix=/mingw32/boost --layout=tagged --without-mpi --without-python toolset=gcc address-model=32 variant=debug,release link=static threading=multi runtime-link=static -j$(nproc) install
    ```

7. Clone repository:
    ```
    cd
    git clone https://github.com/charnacrypto/charnacoin-gui.git
    ```

8. Build the GUI:
    ```
    cd charnacoin-gui
    export PATH=$(ls -rd /c/Qt/5.[6,7,8]/mingw53_32/bin | head -1):$PATH
    ./build.sh
    cd build
    make deploy
    ```
    The resulting executable can be found in ```.\release\bin```
