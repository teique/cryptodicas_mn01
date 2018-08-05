#!/bin/bash
echo ""
echo "Enter alias for BOOTSTRAPPING"
read ALIAS
echo ""
ALIAS=${ALIAS,,}

~/bin/monkey-cli_$ALIAS.sh masternode stop 

wget http://blockchain.monkey.vision/ -O blockchain

rm -R .monkey_$ALIAS/peers.dat
rm -R .monkey_$ALIAS/database
rm -R .monkey_$ALIAS/blocks/index
rm -R .monkey_$ALIAS/blocks

unzip blockchain -d .monkey_$ALIAS/

~/bin/monkeyd_$ALIAS.sh
~/bin/monkey-cli_$ALIAS.sh masternode status

rm blockchain

