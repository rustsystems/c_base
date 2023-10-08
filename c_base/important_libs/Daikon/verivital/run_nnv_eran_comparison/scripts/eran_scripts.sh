#!/bin/bash

TIMEOUT=1h 
cd ERAN/tf_verify 
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_0  --domain=deepzono 2>&1 | tee ../../logs/eran0/results0.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results0.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_1  --domain=deepzono 2>&1 | tee ../../logs/eran0/results1.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results1.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_2  --domain=deepzono 2>&1 | tee ../../logs/eran0/results2.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results2.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_3  --domain=deepzono 2>&1 | tee ../../logs/eran0/results3.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results3.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_4  --domain=deepzono 2>&1 | tee ../../logs/eran0/results4.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results4.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_5  --domain=deepzono 2>&1 | tee ../../logs/eran0/results5.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results5.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_6  --domain=deepzono 2>&1 | tee ../../logs/eran0/results6.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results6.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_7  --domain=deepzono 2>&1 | tee ../../logs/eran0/results7.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results7.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_8  --domain=deepzono 2>&1 | tee ../../logs/eran0/results8.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results8.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_9  --domain=deepzono 2>&1 | tee ../../logs/eran0/results9.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results9.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_10  --domain=deepzono 2>&1 | tee ../../logs/eran0/results10.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results10.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_11  --domain=deepzono 2>&1 | tee ../../logs/eran0/results11.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results11.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_12  --domain=deepzono 2>&1 | tee ../../logs/eran0/results12.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results12.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_13  --domain=deepzono 2>&1 | tee ../../logs/eran0/results13.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results13.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_14  --domain=deepzono 2>&1 | tee ../../logs/eran0/results14.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results14.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_15  --domain=deepzono 2>&1 | tee ../../logs/eran0/results15.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results15.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_16  --domain=deepzono 2>&1 | tee ../../logs/eran0/results16.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results16.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_17  --domain=deepzono 2>&1 | tee ../../logs/eran0/results17.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results17.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_18  --domain=deepzono 2>&1 | tee ../../logs/eran0/results18.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results18.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_19  --domain=deepzono 2>&1 | tee ../../logs/eran0/results19.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results19.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_20  --domain=deepzono 2>&1 | tee ../../logs/eran0/results20.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results20.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_21  --domain=deepzono 2>&1 | tee ../../logs/eran0/results21.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results21.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_22  --domain=deepzono 2>&1 | tee ../../logs/eran0/results22.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results22.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_23  --domain=deepzono 2>&1 | tee ../../logs/eran0/results23.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results23.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_24  --domain=deepzono 2>&1 | tee ../../logs/eran0/results24.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results24.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_25  --domain=deepzono 2>&1 | tee ../../logs/eran0/results25.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results25.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_26  --domain=deepzono 2>&1 | tee ../../logs/eran0/results26.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results26.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_27  --domain=deepzono 2>&1 | tee ../../logs/eran0/results27.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results27.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_28  --domain=deepzono 2>&1 | tee ../../logs/eran0/results28.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results28.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_29  --domain=deepzono 2>&1 | tee ../../logs/eran0/results29.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results29.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_30  --domain=deepzono 2>&1 | tee ../../logs/eran0/results30.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results30.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_31  --domain=deepzono 2>&1 | tee ../../logs/eran0/results31.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results31.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_32  --domain=deepzono 2>&1 | tee ../../logs/eran0/results32.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results32.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_33  --domain=deepzono 2>&1 | tee ../../logs/eran0/results33.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results33.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_34  --domain=deepzono 2>&1 | tee ../../logs/eran0/results34.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results34.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_35  --domain=deepzono 2>&1 | tee ../../logs/eran0/results35.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results35.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_36  --domain=deepzono 2>&1 | tee ../../logs/eran0/results36.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results36.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_37  --domain=deepzono 2>&1 | tee ../../logs/eran0/results37.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results37.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_38  --domain=deepzono 2>&1 | tee ../../logs/eran0/results38.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results38.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_39  --domain=deepzono 2>&1 | tee ../../logs/eran0/results39.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results39.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_40  --domain=deepzono 2>&1 | tee ../../logs/eran0/results40.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results40.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_41  --domain=deepzono 2>&1 | tee ../../logs/eran0/results41.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results41.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_42  --domain=deepzono 2>&1 | tee ../../logs/eran0/results42.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results42.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_43  --domain=deepzono 2>&1 | tee ../../logs/eran0/results43.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results43.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_44  --domain=deepzono 2>&1 | tee ../../logs/eran0/results44.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results44.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_45  --domain=deepzono 2>&1 | tee ../../logs/eran0/results45.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results45.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_46  --domain=deepzono 2>&1 | tee ../../logs/eran0/results46.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results46.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs0/input_47  --domain=deepzono 2>&1 | tee ../../logs/eran0/results47.txt
echo "Time: $SECONDS  "  >> ../../logs/eran0/results47.txt


SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_0  --domain=deepzono 2>&1 | tee ../../logs/eran1/results0.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results0.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_1  --domain=deepzono 2>&1 | tee ../../logs/eran1/results1.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results1.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_2  --domain=deepzono 2>&1 | tee ../../logs/eran1/results2.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results2.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_3  --domain=deepzono 2>&1 | tee ../../logs/eran1/results3.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results3.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_4  --domain=deepzono 2>&1 | tee ../../logs/eran1/results4.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results4.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_5  --domain=deepzono 2>&1 | tee ../../logs/eran1/results5.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results5.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_6  --domain=deepzono 2>&1 | tee ../../logs/eran1/results6.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results6.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_7  --domain=deepzono 2>&1 | tee ../../logs/eran1/results7.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results7.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_8  --domain=deepzono 2>&1 | tee ../../logs/eran1/results8.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results8.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_9  --domain=deepzono 2>&1 | tee ../../logs/eran1/results9.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results9.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_10  --domain=deepzono 2>&1 | tee ../../logs/eran1/results10.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results10.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_11  --domain=deepzono 2>&1 | tee ../../logs/eran1/results11.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results11.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_12  --domain=deepzono 2>&1 | tee ../../logs/eran1/results12.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results12.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_13  --domain=deepzono 2>&1 | tee ../../logs/eran1/results13.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results13.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_14  --domain=deepzono 2>&1 | tee ../../logs/eran1/results14.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results14.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_15  --domain=deepzono 2>&1 | tee ../../logs/eran1/results15.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results15.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_16  --domain=deepzono 2>&1 | tee ../../logs/eran1/results16.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results16.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_17  --domain=deepzono 2>&1 | tee ../../logs/eran1/results17.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results17.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_18  --domain=deepzono 2>&1 | tee ../../logs/eran1/results18.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results18.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_19  --domain=deepzono 2>&1 | tee ../../logs/eran1/results19.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results19.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_20  --domain=deepzono 2>&1 | tee ../../logs/eran1/results20.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results20.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_21  --domain=deepzono 2>&1 | tee ../../logs/eran1/results21.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results21.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_22  --domain=deepzono 2>&1 | tee ../../logs/eran1/results22.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results22.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_23  --domain=deepzono 2>&1 | tee ../../logs/eran1/results23.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results23.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_24  --domain=deepzono 2>&1 | tee ../../logs/eran1/results24.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results24.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_25  --domain=deepzono 2>&1 | tee ../../logs/eran1/results25.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results25.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_26  --domain=deepzono 2>&1 | tee ../../logs/eran1/results26.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results26.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_27  --domain=deepzono 2>&1 | tee ../../logs/eran1/results27.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results27.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_28  --domain=deepzono 2>&1 | tee ../../logs/eran1/results28.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results28.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_29  --domain=deepzono 2>&1 | tee ../../logs/eran1/results29.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results29.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_30  --domain=deepzono 2>&1 | tee ../../logs/eran1/results30.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results30.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_31  --domain=deepzono 2>&1 | tee ../../logs/eran1/results31.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results31.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_32  --domain=deepzono 2>&1 | tee ../../logs/eran1/results32.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results32.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_33  --domain=deepzono 2>&1 | tee ../../logs/eran1/results33.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results33.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_34  --domain=deepzono 2>&1 | tee ../../logs/eran1/results34.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results34.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_35  --domain=deepzono 2>&1 | tee ../../logs/eran1/results35.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results35.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_36  --domain=deepzono 2>&1 | tee ../../logs/eran1/results36.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results36.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_37  --domain=deepzono 2>&1 | tee ../../logs/eran1/results37.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results37.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_38  --domain=deepzono 2>&1 | tee ../../logs/eran1/results38.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results38.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_39  --domain=deepzono 2>&1 | tee ../../logs/eran1/results39.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results39.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_40  --domain=deepzono 2>&1 | tee ../../logs/eran1/results40.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results40.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_41  --domain=deepzono 2>&1 | tee ../../logs/eran1/results41.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results41.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_42  --domain=deepzono 2>&1 | tee ../../logs/eran1/results42.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results42.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_43  --domain=deepzono 2>&1 | tee ../../logs/eran1/results43.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results43.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_44  --domain=deepzono 2>&1 | tee ../../logs/eran1/results44.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results44.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_45  --domain=deepzono 2>&1 | tee ../../logs/eran1/results45.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results45.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_46  --domain=deepzono 2>&1 | tee ../../logs/eran1/results46.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results46.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs1/input_47  --domain=deepzono 2>&1 | tee ../../logs/eran1/results47.txt
echo "Time: $SECONDS  "  >> ../../logs/eran1/results47.txt


SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_0  --domain=deepzono 2>&1 | tee ../../logs/eran2/results0.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results0.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_1  --domain=deepzono 2>&1 | tee ../../logs/eran2/results1.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results1.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_2  --domain=deepzono 2>&1 | tee ../../logs/eran2/results2.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results2.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_3  --domain=deepzono 2>&1 | tee ../../logs/eran2/results3.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results3.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_4  --domain=deepzono 2>&1 | tee ../../logs/eran2/results4.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results4.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_5  --domain=deepzono 2>&1 | tee ../../logs/eran2/results5.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results5.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_6  --domain=deepzono 2>&1 | tee ../../logs/eran2/results6.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results6.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_7  --domain=deepzono 2>&1 | tee ../../logs/eran2/results7.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results7.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_8  --domain=deepzono 2>&1 | tee ../../logs/eran2/results8.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results8.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_9  --domain=deepzono 2>&1 | tee ../../logs/eran2/results9.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results9.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_10  --domain=deepzono 2>&1 | tee ../../logs/eran2/results10.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results10.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_11  --domain=deepzono 2>&1 | tee ../../logs/eran2/results11.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results11.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_12  --domain=deepzono 2>&1 | tee ../../logs/eran2/results12.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results12.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_13  --domain=deepzono 2>&1 | tee ../../logs/eran2/results13.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results13.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_14  --domain=deepzono 2>&1 | tee ../../logs/eran2/results14.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results14.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_15  --domain=deepzono 2>&1 | tee ../../logs/eran2/results15.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results15.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_16  --domain=deepzono 2>&1 | tee ../../logs/eran2/results16.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results16.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_17  --domain=deepzono 2>&1 | tee ../../logs/eran2/results17.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results17.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_18  --domain=deepzono 2>&1 | tee ../../logs/eran2/results18.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results18.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_19  --domain=deepzono 2>&1 | tee ../../logs/eran2/results19.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results19.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_20  --domain=deepzono 2>&1 | tee ../../logs/eran2/results20.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results20.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_21  --domain=deepzono 2>&1 | tee ../../logs/eran2/results21.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results21.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_22  --domain=deepzono 2>&1 | tee ../../logs/eran2/results22.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results22.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_23  --domain=deepzono 2>&1 | tee ../../logs/eran2/results23.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results23.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_24  --domain=deepzono 2>&1 | tee ../../logs/eran2/results24.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results24.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_25  --domain=deepzono 2>&1 | tee ../../logs/eran2/results25.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results25.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_26  --domain=deepzono 2>&1 | tee ../../logs/eran2/results26.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results26.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_27  --domain=deepzono 2>&1 | tee ../../logs/eran2/results27.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results27.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_28  --domain=deepzono 2>&1 | tee ../../logs/eran2/results28.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results28.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_29  --domain=deepzono 2>&1 | tee ../../logs/eran2/results29.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results29.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_30  --domain=deepzono 2>&1 | tee ../../logs/eran2/results30.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results30.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_31  --domain=deepzono 2>&1 | tee ../../logs/eran2/results31.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results31.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_32  --domain=deepzono 2>&1 | tee ../../logs/eran2/results32.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results32.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_33  --domain=deepzono 2>&1 | tee ../../logs/eran2/results33.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results33.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_34  --domain=deepzono 2>&1 | tee ../../logs/eran2/results34.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results34.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_35  --domain=deepzono 2>&1 | tee ../../logs/eran2/results35.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results35.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_36  --domain=deepzono 2>&1 | tee ../../logs/eran2/results36.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results36.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_37  --domain=deepzono 2>&1 | tee ../../logs/eran2/results37.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results37.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_38  --domain=deepzono 2>&1 | tee ../../logs/eran2/results38.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results38.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_39  --domain=deepzono 2>&1 | tee ../../logs/eran2/results39.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results39.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_40  --domain=deepzono 2>&1 | tee ../../logs/eran2/results40.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results40.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_41  --domain=deepzono 2>&1 | tee ../../logs/eran2/results41.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results41.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_42  --domain=deepzono 2>&1 | tee ../../logs/eran2/results42.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results42.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_43  --domain=deepzono 2>&1 | tee ../../logs/eran2/results43.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results43.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_44  --domain=deepzono 2>&1 | tee ../../logs/eran2/results44.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results44.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_45  --domain=deepzono 2>&1 | tee ../../logs/eran2/results45.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results45.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_46  --domain=deepzono 2>&1 | tee ../../logs/eran2/results46.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results46.txt
SECONDS=0
timeout --foreground --signal=SIGQUIT $TIMEOUT python3 -u . --netname=../../models/cifar_conv_maxpool.pyt  --zonotope=../../logs/zonotope_inputs2/input_47  --domain=deepzono 2>&1 | tee ../../logs/eran2/results47.txt
echo "Time: $SECONDS  "  >> ../../logs/eran2/results47.txt


cd ../../