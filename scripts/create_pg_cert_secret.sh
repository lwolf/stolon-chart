#!/bin/bash

BASEDIR=${PWD}
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECTBASE=$SCRIPTDIR/../..

set -euo pipefail

usage() {
cat << EOF

Usage: ${0##*/} -k [key filename] -c [cert filename] [-n [namespace]] [-r] [-h]

creates a secret named 'pg-cert-secret' in the given namespace
from the files specified. They will be used to enable ssl access client access to Postgres

    -h               display this help and exit
    -k               path to the 'server.key' file (required)
    -c               path to the 'server.crt' file (required)
    -n               kubernetes namespace defaults to 'persistence'
    -r               replace the old secret (optional)

EOF
}

namespace="persistence"
keyfilename="server.key"
certfilename="server.crt"
secretname="pg-cert-secret"
key=""
cert=""
replace=false

# getopts & validations
OPTIND=1 # Reset is necessary if getopts was used previously in the script.  It is a good idea to make this local in a function.
while getopts "hk:c:n:r" opt; do
  case "$opt" in
    h)
        usage
        exit 0
        ;;
    k)
        key="$PROJECTBASE/${OPTARG}"
        ;;
    c)
        cert="$PROJECTBASE/${OPTARG}"
        ;;
    n)
        namespace=${OPTARG}
        ;;
    r)
        replace=true
        ;;
    \?)
        usage >&2
        exit 1
        ;;
  esac
done
shift "$((OPTIND-1))" # Shift off the options and optional --.

if [ -z "$key" ]; then
  echo error: no [key] file specified
  usage
  exit 1
else
  if [ ! -f "$key" ]; then
    echo error: [$key] file does not exist
    usage
    exit 1
  fi
fi

if [ -z "$cert" ]; then
  echo error: no [cert] file specified
  usage
  exit 1
else
  if [ ! -f "$cert" ]; then
    echo error: [$cert] file does not exist
    usage
    exit 1
  fi
fi

cp $key /tmp/$keyfilename
cp $cert /tmp/$certfilename

if [ "$replace" = true ]; then
  kubectl delete secret $secretname || true
fi
kubectl --namespace=$namespace create secret generic $secretname --from-file=/tmp/$keyfilename --from-file=/tmp/$certfilename

