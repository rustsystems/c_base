'''
Measurement script for ACAS Xu networks. Runs all benchmarks and produces a summary file in the results folder.

Stanley Bak, 2020
'''

import os
import sys
import time
from pathlib import Path

from termcolor import cprint

from nnenum.settings import Settings
from acasxu_single import verify_acasxu

def main():
    'main entry point'

    start = time.time()

    Settings.TIMING_STATS = False
    Settings.PARALLEL_ROOT_LP = False
    Settings.SPLIT_IF_IDLE = False
    Settings.PRINT_OVERAPPROX_OUTPUT = False

    full_filename = 'results/full_acasxu.dat'
    hard_filename = 'results/hard_acasxu.dat'

    if len(sys.argv) > 1:
        Settings.TIMEOUT = 60 * float(sys.argv[1])
        print(f"Running measurements with timeout = {Settings.TIMEOUT} secs")

    instances = []

    for spec in range(1, 5):
        for a_prev in range(1, 6):
            for tau in range(1, 10):
                instances.append([str(a_prev), str(tau), str(spec)])

    instances.append(["1", "1", "5"])
    instances.append(["1", "1", "6"])
    instances.append(["1", "9", "7"])
    instances.append(["2", "9", "8"])
    instances.append(["3", "3", "9"])
    instances.append(["4", "5", "10"])

    acasxu_hard = [["4", "6", "1"],
                   ["4", "8", "1"],
                   ["3", "3", "2"],
                   ["4", "2", "2"],
                   ["4", "9", "2"],
                   ["5", "3", "2"],
                   ["3", "6", "3"],
                   ["5", "1", "3"],
                   ["1", "9", "7"],
                   ["3", "3", "9"]]

    Path("./results").mkdir(parents=True, exist_ok=True)

    with open(hard_filename, "w") as h:
        with open(full_filename, "w") as f:
            for instance in instances:
                a_prev, tau, spec = instance
                net_pair = (int(a_prev), int(tau))

                res_str = "none"
                secs = -1

                cprint(f"\nRunning net {a_prev}-{tau} with spec {spec}", "grey", "on_green")

                if spec == "7":
                    # ego / 10 processes is beter for deep counterexamples in prop 7
                    Settings.BRANCH_MODE = Settings.BRANCH_EGO
                    Settings.NUM_PROCESSES = 10

                    # property 7 is nondeterministic due to work sharing among processes... use median of 10 runs
                    pretimeout = Settings.TIMEOUT
                    Settings.TIMEOUT = min(5, pretimeout) # smaller timeout to make it go faster
                    runs = 10
                    print(f"\nTrying median of {runs} quick runs")
                    results = []

                    for i in range(runs):
                        print(f"\nTrial {i+1}/{runs}:")
                        res_str, secs = verify_acasxu(net_pair, spec)
                        results.append((secs, res_str))

                    results.sort()
                    print(f"results: {results}")
                    secs, res_str = results[runs // 2] # median

                    print(f"Median: {secs}, {res_str}")

                    Settings.TIMEOUT = pretimeout

                    if res_str == "timeout":
                        # median was timeout; run full
                        res_str, secs = verify_acasxu(net_pair, spec)
                else:
                    Settings.BRANCH_MODE = Settings.BRANCH_OVERAPPROX
                    Settings.NUM_PROCESSES = len(os.sched_getaffinity(0))
                    
                    res_str, secs = verify_acasxu(net_pair, spec)

                s = f"{a_prev}_{tau}\t{spec}\t{res_str}\t{secs}"
                f.write(s + "\n")
                f.flush()
                print(s)

                if instance in acasxu_hard:
                    h.write(s + "\n")
                    h.flush()

    mins = (time.time() - start) / 60.0

    print(f"Completed all measurements in {round(mins, 2)} minutes")

if __name__ == '__main__':
    main()
