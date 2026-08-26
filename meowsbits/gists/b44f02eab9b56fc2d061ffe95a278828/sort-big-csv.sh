#!/usr/bin/env bash

# Sorts a big CSV file by breaking it into small pieces, sorting those, then merging (while sorting) those
# small pieces back into a big one.
# Largely (get it?) taken from https://stackoverflow.com/a/34092506/4401322

# Break big file into small chunk files.
# Set how many lines per chunk file you want.
split -l 1000000 "$1" chunk-

# Remove original big file. It is now redundant to its chunks.
rm "$1"

for f in chunk-*; do
        echo "Sorting $f to sorted-$f"
        
        # Set how many parallel procs you want.
        # Set which columns you want to sort by.
        # -n flags means sort numerically.
        sort --parallel 6 -t',' -k 4,4 -k 5,5 -n < "$f" > "sorted-$f"
        
        # Remove the unsorted chunk file. Saves redundant space.
        rm "$f"
done

# Merge, with sorting, the sorted chunk files back into a big one.
sort -t',' -k 4,4 -k 5,5 -m -n sorted-* > "$1"
