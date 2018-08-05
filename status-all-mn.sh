#!/bin/bash
mn=1
clear
echo Listing ALL Master Nodes Status - by theique
for file in ~/bin/monkey-cli*.sh; do
	echo ""
	ALIAS=${file:`expr index "$file" _`:`expr index "$file" .`-`expr index "$file" _`-1}
	BLOCO=$(~/bin/monkey-cli_$ALIAS.sh getblockcount)
	PROCCESS=`ps -aux | awk -v var_alias="$ALIAS" '$0 ~ var_alias && !/awk/ {print " has pid " $2 " and is Running For: " $10 "h now"}'`
	echo Masternode "$mn", Alias "$ALIAS", is at block "$BLOCO", "$PROCCESS"
	HASH=$(~/bin/monkey-cli_$ALIAS.sh getblockhash $BLOCO)
	echo Hash of block "$BLOCO" in MN "$mn", ALIAS "$ALIAS": "$HASH"
	~/bin/monkey-cli_$ALIAS.sh masternode status
	let mn++
done
echo ""
echo "by theique, if you feel like buying me a beer, MONK me: MbUJLah3ZgbFxmrGgmjJStAdY9R5H935GF"
echo ""


