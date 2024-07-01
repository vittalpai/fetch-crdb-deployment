# Fetch CockroachDB Deployment Info
This repo contains a shell script designed to fetch CockroachDB node details

## Prerequisites

1. CockroackDB Loadbalancer/Node URL along with user credentials
2. Ensure you have `curl` installed on your system. You can check if `curl` is installed by running:
```sh
curl --version
```

## How to Use

1. Clone this repository to your local machine:
```sh
git clone https://github.com/yourusername/fetch-cluster-details.git
```

2.Navigate to the repository directory:
```sh
cd fetch-cluster-details
```

3. Make the script executable:
```sh
chmod +x fetch_cluster_details.sh
```

4. Run the script:
```sh
./fetch_cluster_details.sh
```

5. Follow the prompts to enter the base URL along with User crederntials.

6. The script generates and saves the CRDB deployment information into `crdb_details.json`.
