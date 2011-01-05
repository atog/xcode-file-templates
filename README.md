XCode File Templates
====================

This is a collection of XCode file templates used and created by 10to1.

Available Templates
-------------------

- Data Connector: Connect easily with Core Data

How to install
--------------

Just clone this repo in ~/Library/Application Support/Developer/Shared/XCode/File Templates:

    cd ~/Library/Application\ Support/Developer/Shared/XCode/
    git clone git@github.com:10to1/xcode-file-templates.git 10to1\ File\ Templates

After the cloning you'll have to create a symbolic link to all the _pbfiletemplates_:

    mkdir File\ Templates/10to1                                                                              
    ln -s 10to1-file-templates/*.pbfiletemplate File\ Templates/10to1/.
