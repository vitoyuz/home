#!/bin/sh
RSYNC="rsync -av --delete"
BACKDIR="/Volumes/xyuz/backup"

#home
echo "back home"
cp ~/.bash_profile              $BACKDIR/mac_home/
cp ~/.vimrc                     $BACKDIR/mac_home/
$RSYNC ~/.vim                   $BACKDIR/mac_home/

$RSYNC ~/sync/project           $BACKDIR/sync
$RSYNC ~/sync/personal          $BACKDIR/sync
$RSYNC ~/sync/bookcase          $BACKDIR/sync
$RSYNC ~/sync/resource          $BACKDIR/sync


