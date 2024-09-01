# Guide: Running a Rupaya Validator Node

This guide will walk you through the process of setting up and running a Rupaya validator node.

## Prerequisites

- Docker and Docker Compose installed on your system
- Basic understanding of command-line interfaces
- A machine with at least 4GB of RAM and 50GB of free disk space

## Steps

1. **Clone the Repository**

   Clone the official Rupaya validator setup repository to your local machine:

   ```bash
   git clone https://github.com/rupaya-project/valsetup.git
   cd valsetup
   ```

2. **Set Up Configuration Files**

   Create two files in the project directory:

   - `password.txt`: Contains the password for your node account
   - `private_key.txt`: Contains the private key of your validator account

   Make sure to keep these files secure and do not share them with anyone.

3. **Configure Environment Variables**

   The project likely includes a `.env` file or a sample `.env.example` file. If it doesn't exist, create a `.env` file in the project directory with the following content:

   ```
   NETWORK_ID=499
   SYNCMODE=full
   GCMODE=archive
   HTTP_API=eth,net,web3,txpool,miner
   WS_API=eth,net,web3,txpool,miner
   BOOTNODES=enode://your-bootnode-enode-url-here
   MINER_ETHERBASE=0xYourValidatorAddress
   VERBOSITY=3
   IMPORT_PRIVATE_KEY=true
   ```

   Replace `YourValidatorAddress` with your actual validator address. Adjust any other variables according to the project's specific requirements or recommendations.

4. **Start the Validator Node**

   Run the following command to start your validator node:

   ```bash
   docker-compose up -d
   ```

   This will build and start the Rupaya node in detached mode.

5. **Monitor the Node**

   You can check the logs of your node using:

   ```bash
   docker-compose logs -f
   ```

6. **Share Validator Address**

   After deploying your node, you need to share your validator address with Mobay. This is a crucial step as it allows them to add you to the list of approved validators.

   Join the [Rupaya Discord server](https://discord.gg/cfbNWdThpy) and contact `mobay_` through Discord. Provide them with your validator address (the same address you used in the `MINER_ETHERBASE` environment variable).

7. **Wait for Approval**

   Mobay will review your request and add your address to the list of approved validators. Once approved, your node will start participating in the consensus process.

## Maintenance

- Regularly check for updates to the node software by monitoring the [rupaya-project/valsetup](https://github.com/rupaya-project/valsetup) repository.
- Pull the latest changes and rebuild your node if there are updates:
  ```bash
  git pull
  docker-compose down
  docker-compose up -d --build
  ```
- Monitor your node's performance and connectivity.
- Ensure your system stays online and has a stable internet connection.

## Security Considerations

- Keep your private key and password files secure.
- Regularly update your system and the Docker images.
- Use a firewall to restrict access to your node.
- Consider using SSH key-based authentication if accessing your node remotely.

## Community and Support

Join the [Rupaya Discord server](https://discord.gg/cfbNWdThpy) for community support and updates. For validator-specific inquiries, you can contact `mobay_` directly on Discord.

Remember, running a validator node comes with responsibilities. Ensure you understand the implications and requirements before proceeding. Always refer to the official [rupaya-project/valsetup](https://github.com/rupaya-project/valsetup) repository for the most up-to-date information and instructions.
