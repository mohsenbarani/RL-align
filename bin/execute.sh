#! /bin/bash

# usage:  ./execute.sh configfile "model1 model2 .."
#
#  e.g.  ./execute config-02.cfg (train|test) "data/unfoldings/M*[13579].bp.pnml data/unfoldings/pr[ACEG]*.bp.pnml" 
#        (quotes are important!)   


BINDIR=`dirname $0`
DATADIR=`dirname $BINDIR`/data

CONFIG=$1
CORPUS=$2
MODELS=$3

OUTNAME=`basename $CONFIG | cut -d'.' -f2-6`
rm -rf $DATADIR/results/output-$CORPUS.$OUTNAME
mkdir -p $DATADIR/results/output-$CORPUS.$OUTNAME

for x in $MODELS; do
    name=`basename $x .bp.pnml`
    echo "Aligning $name" >&2
    $BINDIR/align $DATADIR/unfoldings/$name $DATADIR/logs/$name.xes $CONFIG | sort > $DATADIR/results/output-$CORPUS.$OUTNAME/$name.out &
done

wait
