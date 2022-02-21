#!/bin/bash

for f in *.fq.gz; do
    echo mv -- "$f" "${f%.fq.gz}_trimmed.fq.gz"
    mv -- "$f" "${f%.fq.gz}_trimmed.fq.gz"
done

