#!/bin/bash
#type this and ENTER: chmod 755 checksync.sh
#This is the main script to monitor all your MONK Master Nodes in ubuntu VPS
#by theique, if you feel like buying me a beer, MONK me: MbUJLah3ZgbFxmrGgmjJStAdY9R5H935GF
#echo "********************************************************************************************"
#echo "############################################################################################"
mn=0
ERROR=0

for file in ~/bin/monkey-cli*.sh; do
	let mn++
	ALIAS=${file:`expr index "$file" _`:`expr index "$file" .`-`expr index "$file" _`-1}
	MNSTATUSFULL=$($file masternode status)
	MNSTATUS=$(grep -oPm1 "(?<=status)[^<]+" <<< "$MNSTATUSFULL")
	MNSTATUS=${MNSTATUS//[^a-zA-Z0-9 ]/}
	MNMESSAGE=$(grep -oPm1 "(?<=message)[^<]+" <<< "$MNSTATUSFULL")
	MNMESSAGE=${MNMESSAGE//[^a-zA-Z0-9 ]/}

	LASTBLOCK=$($file getblockcount)
	GETBLOCKHASH=$($file getblockhash $LASTBLOCK)
	XML=$(curl -s4 https://www.coinexplorer.net/api/MONK/block?height=$LASTBLOCK)
	
	XMLSUCCESS=$(grep -oPm1 "(?<=success)[^<]+" <<< "$XML")
	XMLSUCCESS=${XMLSUCCESS//[^a-zA-Z0-9]/}
	
	while [ "$XMLSUCCESS" = "false" ]
	do
		#echo "coinexplorer.net returned null XML - retrying..."
		XML=$(curl -s4 https://www.coinexplorer.net/api/MONK/block?height=$LASTBLOCK)
		XMLSUCCESS=$(grep -oPm1 "(?<=success)[^<]+" <<< "$XML")
		XMLSUCCESS=${XMLSUCCESS//[^a-zA-Z0-9]/}
	done
	
	GETBLOCKHASHEXPLORER_B=$(grep -oPm1 "(?<=hash)[^<]+" <<< "$XML")
	GETBLOCKHASHEXPLORER_B=${GETBLOCKHASHEXPLORER_B// /}
	GETBLOCKHASHEXPLORER_B=${GETBLOCKHASHEXPLORER_B//[^a-zA-Z0-9]/}
	PROCCESS=`ps -aux | awk -v var_alias="$ALIAS" '$0 ~ var_alias && !/awk/ {print " at pid " $2 ", Running For: " $10 "h now"}'`
	
	echo "###############################################################################################"
	echo Masternode "$mn", Alias "$ALIAS"
	echo $MNMESSAGE $PROCCESS at Block $LASTBLOCK
	echo "HASH_VPS_LOCAL_MASTER_NODE="$GETBLOCKHASH
	echo "HASH_COINEXPLORER_NET_MONK="$GETBLOCKHASHEXPLORER_B
	if [ "$GETBLOCKHASH" == "$GETBLOCKHASHEXPLORER_B" ]; then
		echo "Your Master Node $mn Alias $ALIAS is SYNCED WITH COINEXPLORER! OK!!!"
	else
		let ERROR=$ERROR+1
		echo "Your Master Node $mn Alias $ALIAS is NOT SYNCED WITH COINEXPLORER!"
		echo ""
		echo "MASTER NODE $mn ALIAS $ALIAS IS OUT OF SYNC!!! ATENTION NEEDED!!!"
		echo ""
		echo XML: $XML
		echo ""
	fi
done

if [ "$mn" -gt 1 ]; then
	if [ "$ERROR" == 0 ]; then
		echo "###############################################################################################"
		echo Congratulations! All $mn Master Nodes are OK!!!
	fi
fi

echo "###############################################################################################"
echo "by theique, if you feel like buying me a beer, MONK me: MbUJLah3ZgbFxmrGgmjJStAdY9R5H935GF"
echo "###############################################################################################"