#/bin/bash


if [ -d "logs/" ]; then
    rm -r logs/
fi

mkdir -p logs/

cd scripts
python3 create_bash_scripts.py
cd ..

sudo chmod +x scripts/eran_scripts.sh
sudo chmod +x scripts/nnv_scripts.sh

./scripts/eran_scripts.sh
./scripts/nnv_scripts.sh
cd scripts
python3 load_results.py
cd ..


