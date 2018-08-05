#!/bin/bash

wget http://blockchain.monkey.vision/ -O blockchain

for file in ~/bin/monkey-cli*.sh; do
	ALIAS=${file:`expr index "$file" _`:`expr index "$file" .`-`expr index "$file" _`-1}
	~/bin/monkey-cli_$ALIAS.sh masternode stop 
	rm -R .monkey_$ALIAS/peers.dat
	rm -R .monkey_$ALIAS/database
	rm -R .monkey_$ALIAS/blocks/index
	rm -R .monkey_$ALIAS/blocks
	unzip blockchain -d .monkey_$ALIAS/
	~/bin/monkeyd_$ALIAS.sh
	~/bin/monkey-cli_$ALIAS.sh masternode status
	~/bin/monkey-cli_$ALIAS.sh getblockcount
done

rm blockchain




