ls ~/bin/monkey-cli*.sh | awk '{print("********************************************************************");print("MASTERNODE: "$1);system($1 " getblockcount")}'

