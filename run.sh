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
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbis.fst | dot -Tpdf  > verbisdis.pdf


# Verbif
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbif.txt | fstarcsort > verbif.fst
fstconcat verbif.fst lemma.fst > lemma2verbif.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbif.fst | dot -Tpdf  > verbif.pdf

# Verb
fstrmepsilon lemma2verbis.fst lemma2verbis.fst
fstrmepsilon lemma2verbif.fst lemma2verbif.fst
fstrmepsilon lemma2verbip.fst lemma2verbip.fst
fstunion lemma2verbis.fst lemma2verbip.fst > lemma2verbtemp.fst
fstrmepsilon lemma2verbtemp.fst lemma2verbtemp.fst

fstunion lemma2verbif.fst lemma2verbtemp.fst > lemma2verb.fst
#fstdeterminize lemma2verb.fst lemma2verb.fst

fstunion lemma2verb.fst lemma2adverb.fst > lemma2wordtemp.fst
fstrmepsilon lemma2wordtemp.fst lemma2wordtemp.fst
fstunion lemma2noun.fst lemma2wordtemp.fst > lemma2word.fst
#fstunion lemma2verbtemp.fst lemma2verbif.fst > lemma2verbprenorm.fst
#fstepsnormalize lemma2verbprenorm.fst lemma2verbpredet.fst
#fstdisambiguate lemma2verbpredet.fst lemma2verb.fst
#could also minimize if needed
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verb.fst | dot -Tpdf  > verb.pdf



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



