var hashrateFloor = 20000;
for (;true;) {
    var sleepInterval = 60;
    if (!eth.mining) {
        console.log(Date(), "starting miner")
        miner.start();
        sleepInterval = 60*10;
    }
    var hashrate = miner.getHashrate();
    console.log(Date() , "hashrate", hashrate);
    if (hashrate < hashrateFloor) {
        console.log(Date(), "hashrate below floor, stopping miner")
        miner.stop();
        sleepInterval = 60*30;
    }
    admin.sleep(sleepInterval);
}