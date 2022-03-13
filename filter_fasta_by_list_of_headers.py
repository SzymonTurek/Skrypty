from Bio import SeqIO

fasta_file = "/Volumes/One_Touch/ragtag/ragtag_v2/chinese_reference/ChineseLong_genome_v3.fa" # Input fasta file
wanted_file = "/Volumes/One_Touch/ragtag/ragtag_v2/chinese_reference/chinese_filter.txt" # Input interesting sequence IDs, one per line
result_file = "/Volumes/One_Touch/ragtag/ragtag_v2/chinese_reference/filtered.fasta" # Output fasta file

wanted = set()
with open(wanted_file) as f:
    for line in f:
        line = line.strip()
        if line != "":
            wanted.add(line)

fasta_sequences = SeqIO.parse(open(fasta_file),'fasta')
with open(result_file, "w") as f:
    for seq in fasta_sequences:
        if seq.id in wanted:
            SeqIO.write([seq], f, "fasta")