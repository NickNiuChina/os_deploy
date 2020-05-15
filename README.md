# os_deploy
Based on the DRBL pxe environment, all the clients boot up into drbl during 1st boot. Then automatically login and run bash script to call the main perl script. The perl sctipt create new boot menu using the client mac addresss, read the ip and hostname info from database, then set the ks and grun.cfg for the ragarding mac. So when this units boot up 2nd, it start installing os automatically.
And the crontab will delete the menu wiht mac every 5 min in order to make the units boot up into drbl if 2nd imaging.

The file path may not be correct, please change the path and set up env if you use this script.

No warranty and thanks.
