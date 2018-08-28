#! /usr/bin/env bash

## unfortunately, the blasr/sparc consensus doesn't often run properly out-of-the-box ##
## this script will configure the blasr/sparc components to install correctly into your $PATH ##

cat <<EOF

This script will download the split_and_run script from Sparc, configure script to work correctly, and move it to the global PATH at /bin/ 
The easiest way to have all the other parts work is to create a conda environment configured for python2 and install blasr and Sparc into that.

[example] 
conda create -n consensus
conda activate consensus
conda install -c bioconda python=2.7 blasr sparc

EOF

# function from user Chronial on StackExchange
# (https://stackoverflow.com/users/758345/chronial)

function git_sparse_clone() (
  rurl="$1" localdir="$2" && shift 2

  mkdir -p "$localdir"
  cd "$localdir"

  git init
  git remote add -f origin "$rurl"

  git config core.sparseCheckout true

  # Loops over remaining args
  for i; do
    echo "$i" >> .git/info/sparse-checkout
  done

  git pull origin master
)

echo "fetching utility scripts from DBG2OLC github..."
git_sparse_clone "http://github.com/yechengxi/DBG2OLC" "./DBG_consensus" "/utility" &> out.log  

rm out.log
cd DBG_consensus/utility

echo "removing unneeded scripts and tweaking split_and_run_sparc.sh"

# remove stuff I won't be using. can be changed if you need other stuff
rm split_and_run_sparc.sh split_and_run_sparc.path.sh *batches.sh *pbdagcon* *.txt

sed -i -e 's/-nproc/--nproc/g' split_and_run_sparc.2.sh
sed -i -e 's/-bestn/--bestn/g' split_and_run_sparc.2.sh
sed -i -e 's/-minMatch/--minMatch/g' split_and_run_sparc.2.sh
sed -i -e 's/-out/--out/g' split_and_run_sparc.2.sh
sed -i -e 's/.\/\Sparc/Sparc/g' split_and_run_sparc.2.sh

chmod +x *

mv split_and_run_sparc.2.sh ./split_and_run_sparc.sh
echo "password needed to move scripts to /bin"
sudo cp * /bin/ && echo "Done! split_and_run_sparc, along with the necessary python scripts \n are executable and copied to /bin/"
