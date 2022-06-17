#!/bin/bash
sudo ufw disable
if [ -d "/root/idena-node-proxy" ]; then
echo "idena-node-proxy already installed"
else
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git unzip curl screen -y
# Node.js instalation updated to 18
#curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
#sudo apt-get install -y nodejs
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

mkdir datadir && cd datadir
mkdir idenachain.db && cd idenachain.db
wget "https://sync.idena.site/idenachain.db.zip"
unzip idenachain.db.zip && rm idenachain.db.zip
cd ../..

curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest \
| grep browser_download_url \
| grep idena-node-linux-0.* \
| cut -d '"' -f 4 \
| wget -qi -
mv idena-* idena-go && chmod +x idena-go
bash -c 'echo "{\"IpfsConf\":{\"Profile\": \"server\" ,\"FlipPinThreshold\":1},\"Sync\": {\"LoadAllFlips\": true, \"AllFlipsLoadingTime\":7200000000000}}" > config.json'

#this is conf for minimal test node
#bash -c 'echo "{\"P2P\":{\"MaxInboundPeers\":4,\"MaxOutboundPeers\":1},\"IpfsConf\":{\"Profile\":\"server\",\"BlockPinThreshold\":0.1,\"FlipPinThreshold\":0.1}}" > config.json'

touch node-restarted.log

tee update << 'EOF'
killall screen
rm idena-go
curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep browser_download_url | grep idena-node-linux-0.* | cut -d '"' -f 4 | wget -qi -
mv idena-node-linux* idena-go
chmod +x idena-go
screen -dmS node $PWD/start
echo Update was successfull
EOF
chmod +x update

tee version << 'EOF'
curl 'http://127.0.0.1:9009/' -H 'Content-Type: application/json' --data '{"method":"dna_version","params":[{}],"id":1,"key":"123"}'
EOF
chmod +x version

bash -c 'echo "while :
do
./idena-go --config=config.json --profile=shared --apikey=123
date >> node-restarted.log
done" > start'
chmod +x start
(crontab -l 2>/dev/null; echo "@reboot screen -dmS node $PWD/start") | crontab -

#npm i npm@latest -g
git clone https://github.com/idena-network/idena-node-proxy
npm i -g pm2

cd idena-node-proxy
https://raw.githubusercontent.com/skuple/idna-script/main/index.html

bash -c 'echo "AVAILABLE_KEYS=[\"IBXQfFiK4J\",\"2mSzTBFeMS\",\"SFA628jWTg\",\"1kmklvm29n\",\"6XGhxE2GER\",\"5OZcfurOFa\",\"BsxVZt0APe\",\"HBglDNqQTX\",\"zByFzkFRbk\",\"lTXqeiwk1A\",\"PddLjbr0XQ\",\"WR6PnP7WTb\",\"Orl8epeENI\",\"8489Dvp57L\",\"fZcqQClb2X\",\"UDVw2gT2Ww\",\"vNjVxpFN3o\",\"VxPuVF5TR1\",\"9ENWmlaJnY\",\"dWB9gwnwYk\",\"jvoLR3jzIH\",\"ouDiZffffW\",\"m4nGjry61v\",\"MlD8Xw3aBY\",\"hDxViBUnmx\",\"d8DbiE2cV2\",\"9eBrTw5fWB\",\"BBAbCvpztI\",\"WrDvURmKEV\",\"epalcuZRqo\",\"i9iwywISPU\",\"TjQDcsJGNQ\",\"F3wE1LOUOQ\",\"GeyKVATuKm\",\"FWaLty0Rhq\",\"7Mx9tzfRHS\",\"a8fblaabbQ\",\"WgmoPfymzJ\",\"U4ueElITjN\",\"rrpa1DxDId\",\"waC5eb4SnW\",\"RvWwA1Ff6T\",\"ZmMv5BQ58i\",\"MVui8e3bGP\",\"OTynFxt4EM\",\"9Hmthoz6LT\",\"YN6l6hB9yd\",\"zQuO5gYelF\",\"NbVWOVYhVc\",\"dycwYuuN3w\",\"AabC3jDK7w\",\"JfcRjg7JIR\",\"hBopXJVgJL\",\"fWUu7uzxpH\",\"cJjmXs4vQ0\",\"6OnoMzTc5R\",\"FPA0dxGDro\",\"xrzi9GeYn7\",\"LbO9VIUPKT\",\"CY9aHNvIce\",\"4UJMdTK2Dw\",\"QpyUjsgDV9\",\"IJnodff82r\",\"ax02MTsz5Z\",\"AicQpqKGpX\",\"vuyNQ9sJKs\",\"W4oGmhTY6i\",\"7FQElSNKsB\",\"MgXok6PA3e\",\"ikbHmERu45\",\"Xte3ngl5N0\",\"MftJDpJI5z\",\"VV88CX9SUO\",\"3ihtvA7DkL\",\"kPTnTbXvZs\",\"Kd2FAv3bCg\",\"kW4ZiPPmAi\",\"fWf9dRaCIE\",\"c4KysmpGfn\",\"44n2scVJja\",\"dCoqGbMVIU\",\"MBuvHSXKdQ\",\"IXmf0XQipu\",\"ht0RuscNit\",\"8vor5OPPgn\",\"YNSGg2uBGD\",\"LD8idHM0n8\",\"GAOd4c6Gdz\",\"ujLpCzVsUh\",\"tYVcD0NEqr\",\"sWmKp8zDKo\",\"5yei5a5CTZ\",\"ENDvcxEbgX\",\"RrCsrMYE8D\",\"QzZzUqAZuJ\",\"vC4FldOawP\",\"aKfv83Sy4u\",\"9xpfPNVBXq\",\"AmgaZVwnoj\",\"GwDENnAPfK\",\"ORvUvxHKWN\",\"PLhuYddhao\",\"vFcgoCvol6\",\"DecWKeVIh0\",\"UvEzgT1bw7\",\"qxRqZ68z25\",\"pniOIN0dM6\",\"QFQGJBAHpt\",\"WNkqtYQF4q\",\"nciN79WwV5\",\"Xl59lonTLB\",\"itKDrdKhnc\",\"K7N7ZY518V\",\"pSXWC8Lnaa\",\"JKUCA1JdVv\",\"c7I6KGR7Gc\",\"eOfXI14Iq9\",\"pYiVMpVhvt\",\"mltZYkUPVL\",\"FGILWtH0fg\",\"RTVdvVVub5\",\"cQeR8Sb9LG\",\"1ZpI4K69Qm\",\"6lfjDsO6hC\",\"P65X0wS0Wc\",\"mpUU76Cfo1\",\"QKNp1y3qSV\",\"1JSyFp8JVA\",\"L8gG578RRI\",\"fgO4rBylwG\",\"G9cDlkF78A\",\"QzOZ4pESUM\",\"AQK4422TcN\",\"RTtFKOh0Ae\",\"QY8MofDBWi\",\"lXKhoiUcXa\",\"RJWXUZ3HX1\",\"TiQBxMX6mI\",\"2eIrCZwFZP\",\"NFq3TBFrxi\",\"XGcRP8JSL1\",\"e2fVFRC4iC\",\"PnqWqXEiFR\",\"tDMxNikNRa\",\"Qb9usYJYl1\",\"4rxhtHe0Kf\",\"nWxzFTa9jV\",\"fUZQk8UDUi\",\"K0bonlzBnA\",\"6uwiUwVAuV\",\"G5gfPJ4gVO\",\"mKh4OA0Cp1\",\"JYwWXvyEIy\",\"Jn6BiT4tiX\",\"30AsfLzysq\",\"Jp8WckEOcH\",\"RtziyHPDdF\",\"orhlpt3MV9\",\"G84ScuGyXf\",\"ZosUC17uQ0\",\"lHXeH48LDi\",\"ysA48x4YKn\",\"N8i4JWJMIG\",\"3fyFiuMvML\",\"Pe5V4pi0R2\",\"QgR7twytYI\",\"Y5hGLnajiH\",\"iRWvyoP8BY\",\"TG6au2auV7\",\"RLBK6mAJ4F\",\"sdUfH6tTyG\",\"xtDGkK4RXd\",\"303TCEyPtM\",\"Rg8QgHQxyZ\",\"ndb3cz9kZC\",\"c4a0tscNuf\",\"JMmCTuPtIk\",\"DfPxBTRBDc\",\"dUlzZkB6A8\",\"PsZzpMqXQP\",\"KTL5IKPDlF\",\"rGS5ZQRjSy\",\"Ht6KpDXCnI\",\"5rnYAo4ycC\",\"X7RYBlaMs0\",\"edrhwqvjOi\",\"Vd0hGXLlgn\",\"F65vdsgrwu\",\"GOe0onm8Dt\",\"NCSQHKKL83\",\"BnzCsaQtSb\",\"Kic4vykreo\",\"RTHOJ1Ma1T\",\"7pvkqSz8b8\",\"Dtrn1H54aA\",\"0zOGTrRNWy\",\"0u9pMHDnmM\",\"O8zkm83ETl\",\"egJYwwUoX8\",\"7uOoskYD96\"]
IDENA_URL=\"http://localhost:9009\"
IDENA_KEY=\"123\"
PORT=80" > .env'
#GOD_API_KEY=\"test\"
#REMOTE_KEYS_ENABLED=0

npm install
sed -i 's/stdout/file/g' config_default.json
npm start
pm2 startup
sudo reboot
fi
