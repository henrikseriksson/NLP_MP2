#!/bin/bash


################### Transducers ################

fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma.txt | fstarcsort > lemma.fst

# Noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2noun.txt | fstarcsort > noun.fst
fstconcat noun.fst lemma.fst > lemma2noun.fst

# Adverb
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2adv.txt | fstarcsort > adv.fst
fstconcat adv.fst lemma.fst > lemma2adverb.fst

# Verbip
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbip.txt | fstarcsort > verbip.fst
fstconcat verbip.fst lemma.fst > lemma2verbip.fst

# Verbis
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbis.txt | fstarcsort > verbis.fst
fstconcat verbis.fst lemma.fst > lemma2verbis.fst

# Verbif
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbif.txt | fstarcsort > verbif.fst
fstconcat verbif.fst lemma.fst > lemma2verbif.fst

# Verb
fstrmepsilon lemma2verbis.fst lemma2verbis.fst
fstrmepsilon lemma2verbif.fst lemma2verbif.fst
fstrmepsilon lemma2verbip.fst lemma2verbip.fst
fstunion lemma2verbis.fst lemma2verbip.fst > lemma2verbtemp.fst
fstrmepsilon lemma2verbtemp.fst lemma2verbtemp.fst
fstunion lemma2verbif.fst lemma2verbtemp.fst > lemma2verb.fst

# Word
fstunion lemma2verb.fst lemma2adverb.fst > lemma2wordtemp.fst
fstrmepsilon lemma2wordtemp.fst lemma2wordtemp.fst
fstunion lemma2noun.fst lemma2wordtemp.fst > lemma2word.fst
fstrmepsilon lemma2word.fst lemma2word.fst
fstdeterminize lemma2word.fst lemma2word.fst
fstinvert lemma2word.fst word2lemma.fst


# Draw
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2noun.fst | dot -Tpdf  > lemma2noun.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2adverb.fst | dot -Tpdf  > lemma2adverb.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbip.fst | dot -Tpdf  > lemma2verbip.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbis.fst | dot -Tpdf  > lemma2verbis.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbif.fst | dot -Tpdf  > lemma2verbif.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verb.fst | dot -Tpdf  > lemma2verb.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2word.fst | dot -Tpdf  > lemma2word.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait word2lemma.fst | dot -Tpdf  > word2lemma.pdf



#################################
# Test run 1
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test1.txt | fstarcsort > test1.fst
# Use the reverse fst of test1
fstreverse test1.fst > test1r.fst
fstcompose test1r.fst lemma2word.fst > testresult1r.fst
# Reverse the result back to normal
fstreverse testresult1r.fst > testresult1.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult1.fst | dot -Tpdf  > testresult1.pdf
# Print result
fstproject --project_output testresult1.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 2
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test2.txt | fstarcsort > test2.fst
fstreverse test2.fst > test2r.fst
fstcompose test2r.fst lemma2word.fst > testresult2r.fst
fstreverse testresult2r.fst > testresult2.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult2.fst | dot -Tpdf  > testresult2.pdf
fstproject --project_output testresult2.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 3
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test3.txt | fstarcsort > test3.fst
fstreverse test3.fst > test3r.fst
fstcompose test3r.fst lemma2word.fst > testresult3r.fst
fstreverse testresult3r.fst > testresult3.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult3.fst | dot -Tpdf  > testresult3.pdf
fstproject --project_output testresult3.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 4
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test4.txt | fstarcsort > test4.fst
fstreverse test4.fst > test4r.fst
fstcompose test4r.fst lemma2word.fst > testresult4r.fst
fstreverse testresult4r.fst > testresult4.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult4.fst | dot -Tpdf  > testresult4.pdf
fstproject --project_output testresult4.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 5
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test5.txt | fstarcsort > test5.fst
fstreverse test5.fst > test5r.fst
fstcompose test5r.fst lemma2word.fst > testresult5r.fst
fstreverse testresult5r.fst > testresult5.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult5.fst | dot -Tpdf  > testresult5.pdf
fstproject --project_output testresult5.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 6
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test6.txt | fstarcsort > test6.fst
fstreverse test6.fst > test6r.fst
fstcompose test6r.fst word2lemma.fst > testresult6r.fst
fstreverse testresult6r.fst > testresult6.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait testresult6.fst | dot -Tpdf  > testresult6.pdf
fstproject --project_output testresult6.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt


