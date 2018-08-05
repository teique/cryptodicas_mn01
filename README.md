by theique, if you feel like buying me a beer, MONK me: MbUJLah3ZgbFxmrGgmjJStAdY9R5H935GF


# checksync.sh
#This is the main script to monitor all your MONK Master Nodes in ubuntu
#After downloading the script, give execution permission by typing this and ENTER: chmod 755 checksync.sh
#It will index your Masternodes and list them from 1 to N telling you:
#
#Masternode Alias
#Masternode Status
#Masternode Proccess ID
#How long it's been running for
#The Block the Masternos is at the momment
#Will get the block hash, get coinexplorer.net last block, compare it and print
#If all is synced, an OK message at the end, if some is not, you will get as many erros messages as MN's were out of sync, printing the #XML from coinexplorer.net also


# status-all-mn.sh
#This will print several important information of all your MONK Masternodes running in your ubuntu 


# block-count-all-mn.sh
#This will print Masternodes blocks at the time


# bootstrap-mn.sh
#If one of your MONK Masternodes ever get out of sync, run this and it will download the current MONK blockchain and reset/resync your #Masternode, Alias of the masternode to resync will be required.


# bootstrap-all-mn.sh
#If ALL your MONK Masternodes ever get out of sync, run this and it will download the current MONK blockchain and reset/resync ALL your Masternodes, NO Aliases required.
