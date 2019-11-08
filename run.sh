#!/bin/bash


################### Transducers ################
#
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma_noun.txt | fstarcsort > lemma_noun.fst
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma_adv.txt | fstarcsort > lemma_adv.fst

# Noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt  noun.txt | fstarcsort > noun.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait noun.fst | dot -Tpdf  > noun.pdf

# Adv
fstcompile --isymbols=syms.txt --osymbols=syms.txt  adv.txt | fstarcsort > adv.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait adv.fst | dot -Tpdf  > adv.pdf

# Lemma2Noun
fstconcat lemma_adv.fst adv.fst > lemma2adv.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2adv.fst | dot -Tpdf  > lemma2adv.pdf

#################################
# Test run 1
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test1.txt | fstarcsort > test1.fst
fstcompose test1.fst lemma2noun.fst > testresult1.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult1.fst | dot -Tpdf  > testresult1.pdf


# Print result
fstproject --project_output testresult1.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt
