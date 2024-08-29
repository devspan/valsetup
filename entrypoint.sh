#!/bin/bash

# Read secrets
PRIVATE_KEY=$(cat /run/secrets/node_private_key)
PASSWORD_FILE=/run/secrets/node_password

# Get external IP
EXTERNAL_IP=$(curl -s https://api.ipify.org)
if [ -z "$EXTERNAL_IP" ]; then
    echo "Failed to get external IP. Falling back to 0.0.0.0"
    EXTERNAL_IP="0.0.0.0"
fi
echo "External IP: $EXTERNAL_IP"

# Check if the genesis block needs to be initialized
if [ ! -d /root/.ethereum/geth/chaindata ]; then
    echo "Initializing genesis block..."
    geth init /root/genesis.json
    echo "Genesis block initialized."
else
    echo "Genesis already initialized. Skipping..."
fi

# Import private key if IMPORT_PRIVATE_KEY is set to true
if [ "$IMPORT_PRIVATE_KEY" = "true" ]; then
    echo "Importing private key..."
    ACCOUNT=$(geth account import --password $PASSWORD_FILE <(echo $PRIVATE_KEY))
    ACCOUNT=${ACCOUNT#*Address: \{}
    ACCOUNT=${ACCOUNT%\}*}
    echo "Imported account: 0x$ACCOUNT"
else
    echo "Using existing account..."
    ACCOUNT=$(geth account list | head -n1 | cut -d'{' -f2 | cut -d'}' -f1)
    if [ -z "$ACCOUNT" ]; then
        echo "No account found. Please set IMPORT_PRIVATE_KEY to true or create an account manually."
        exit 1
    fi
    echo "Using account: 0x$ACCOUNT"
fi

# Construct the geth command
CMD="geth --networkid ${NETWORK_ID} \
  --syncmode ${SYNCMODE} \
  --gcmode ${GCMODE} \
  --http \
  --http.addr 0.0.0.0 \
  --http.port 8545 \
  --http.api ${HTTP_API} \
  --http.corsdomain '*' \
  --http.vhosts=* \
  --ws \
  --ws.addr 0.0.0.0 \
  --ws.port 8546 \
  --ws.api ${WS_API} \
  --bootnodes ${BOOTNODES} \
  --mine \
  --miner.etherbase ${MINER_ETHERBASE:-0x$ACCOUNT} \
  --unlock 0x$ACCOUNT \
  --password $PASSWORD_FILE \
  --allow-insecure-unlock \
  --nat extip:${EXTERNAL_IP} \
  --verbosity ${VERBOSITY}"

# Execute the command
exec $CMD