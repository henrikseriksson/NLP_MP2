#!/bin/bash


################### Transducers ################
#
#fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma_noun.txt | fstarcsort > lemma_noun.fst
#fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma_adv.txt | fstarcsort > lemma_adv.fst

# Noun
#fstcompile --isymbols=syms.txt --osymbols=syms.txt  noun.txt | fstarcsort > noun.fst
#fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait noun.fst | dot -Tpdf  > noun.pdf

# Adv
#fstcompile --isymbols=syms.txt --osymbols=syms.txt  adv.txt | fstarcsort > adv.fst
#fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait adv.fst | dot -Tpdf  > adv.pdf

# Lemma2Noun
#fstconcat lemma_adv.fst adv.fst > lemma2adv.fst
#fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2adv.fst | dot -Tpdf  > lemma2adv.pdf

fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma.txt | fstarcsort > lemma.fst


# Adverb
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2adv.txt | fstarcsort > adv.fst
fstconcat adv.fst lemma.fst > lemma2adverb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2adverb.fst | dot -Tpdf  > adv.pdf

# Noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2noun.txt | fstarcsort > noun.fst
fstconcat noun.fst lemma.fst > lemma2noun.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2noun.fst | dot -Tpdf  > noun.pdf

# Verbip
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbip.txt | fstarcsort > verbip.fst
fstconcat verbip.fst lemma.fst > lemma2verbip.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbip.fst | dot -Tpdf  > verbip.pdf

# Verbis
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbis.txt | fstarcsort > verbis.fst
fstconcat verbis.fst lemma.fst > lemma2verbis.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbis.fst | dot -Tpdf  > verbis.pdf

# Verbif
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbif.txt | fstarcsort > verbif.fst
fstconcat verbif.fst lemma.fst > lemma2verbif.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbif.fst | dot -Tpdf  > verbif.pdf

#################################
# Test run 1
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test1.txt | fstarcsort > test1.fst
# Use the reverse fst of test1
fstreverse test1.fst > test1r.fst
fstcompose test1r.fst lemma2noun.fst > testresult1r.fst
# Reverse the result back to normal
fstreverse testresult1r.fst > testresult1.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult1.fst | dot -Tpdf  > testresult1.pdf
# Print result
fstproject --project_output testresult1.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 2
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test2.txt | fstarcsort > test2.fst
# Use the reverse fst of test2
fstreverse test2.fst > test2r.fst
fstcompose test2r.fst lemma2adverb.fst > testresult2r.fst
# Reverse the result back to normal
fstreverse testresult2r.fst > testresult2.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult2.fst | dot -Tpdf  > testresult2.pdf
# Print result
fstproject --project_output testresult2.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 3
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test3.txt | fstarcsort > test3.fst
# Use the reverse fst of test3
fstreverse test3.fst > test3r.fst
fstcompose test3r.fst lemma2verbip.fst > testresult3r.fst
# Reverse the result back to normal
fstreverse testresult3r.fst > testresult3.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult3.fst | dot -Tpdf  > testresult3.pdf
# Print result
fstproject --project_output testresult3.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 4
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test4.txt | fstarcsort > test4.fst
# Use the reverse fst of test4
fstreverse test4.fst > test4r.fst
fstcompose test4r.fst lemma2verbis.fst > testresult4r.fst
# Reverse the result back to normal
fstreverse testresult4r.fst > testresult4.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult4.fst | dot -Tpdf  > testresult4.pdf
# Print result
fstproject --project_output testresult4.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 5
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test5.txt | fstarcsort > test5.fst
# Use the reverse fst of test5
fstreverse test5.fst > test5r.fst
fstcompose test5r.fst lemma2verbif.fst > testresult5r.fst
# Reverse the result back to normal
fstreverse testresult5r.fst > testresult5.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult5.fst | dot -Tpdf  > testresult5.pdf
# Print result
fstproject --project_output testresult5.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt



