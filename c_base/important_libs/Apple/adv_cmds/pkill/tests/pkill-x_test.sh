#!/bin/sh
# $FreeBSD$

base=`basename $0`

echo "1..4"

#ifdef __APPLE__
fails=0
#endif
name="pkill -x"
sleep=$(pwd)/sleep.txt
ln -sf /bin/sleep $sleep
$sleep 5 &
sleep 0.3
pkill -x slee -P $$
if [ $? -ne 0 ]; then
	echo "ok 1 - $name"
else
	echo "not ok 1 - $name"
#ifdef __APPLE__
	fails=$((fails + 1))
#endif
fi
#ifdef __APPLE__
# macOS preserves the link's name.
pkill -x sleep.txt -P $$
#else
#pkill -x sleep -P $$
#endif
if [ $? -eq 0 ]; then
	echo "ok 2 - $name"
else
	echo "not ok 2 - $name"
#ifdef __APPLE__
	fails=$((fails + 1))
#endif
fi
rm -f $sleep

name="pkill -x -f"
sleep=$(pwd)/sleep.txt
ln -sf /bin/sleep $sleep
$sleep 5 &
sleep 0.3
pkill -x -f "$sleep " -P $$
if [ $? -ne 0 ]; then
	echo "ok 3 - $name"
else
	echo "not ok 3 - $name"
#ifdef __APPLE__
	fails=$((fails + 1))
#endif
fi
pkill -x -f "$sleep 5" -P $$
if [ $? -eq 0 ]; then
	echo "ok 4 - $name"
else
	echo "not ok 4 - $name"
#ifdef __APPLE__
	fails=$((fails + 1))
#endif
fi
rm -f $sleep
#ifdef __APPLE__
exit $fails
#endif
