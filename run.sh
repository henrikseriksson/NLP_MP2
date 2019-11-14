#!/bin/bash
#################### Folders ####################
mkdir -p -- "FINALtransducers"
mkdir -p -- "FINALpdf"
mkdir -p -- "FINALexamples"

################### Transducers ################
# Alphabet Aceptor
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma.txt | fstarcsort > lemma.fst

# Noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2noun.txt | fstarcsort > noun.fst
fstconcat noun.fst lemma.fst > ./FINALtransducers/lemma2noun.fst

# Adverb
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2adv.txt | fstarcsort > adv.fst
fstconcat adv.fst lemma.fst > ./FINALtransducers/lemma2adverb.fst

# Verbip
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbip.txt | fstarcsort > verbip.fst
fstconcat verbip.fst lemma.fst > ./FINALtransducers/lemma2verbip.fst

# Verbis
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbis.txt | fstarcsort > verbis.fst
fstconcat verbis.fst lemma.fst > ./FINALtransducers/lemma2verbis.fst

# Verbif
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbif.txt | fstarcsort > verbif.fst
fstconcat verbif.fst lemma.fst > ./FINALtransducers/lemma2verbif.fst

# Verb
fstrmepsilon ./FINALtransducers/lemma2verbis.fst ./FINALtransducers/lemma2verbis.fst
fstrmepsilon ./FINALtransducers/lemma2verbif.fst ./FINALtransducers/lemma2verbif.fst
fstrmepsilon ./FINALtransducers/lemma2verbip.fst ./FINALtransducers/lemma2verbip.fst
fstunion ./FINALtransducers/lemma2verbis.fst ./FINALtransducers/lemma2verbip.fst > lemma2verbtemp.fst
fstrmepsilon lemma2verbtemp.fst lemma2verbtemp.fst
fstunion ./FINALtransducers/lemma2verbif.fst lemma2verbtemp.fst > ./FINALtransducers/lemma2verb.fst

# Word
fstunion ./FINALtransducers/lemma2verb.fst ./FINALtransducers/lemma2adverb.fst > lemma2wordtemp.fst
fstrmepsilon lemma2wordtemp.fst lemma2wordtemp.fst
fstunion ./FINALtransducers/lemma2noun.fst lemma2wordtemp.fst > ./FINALtransducers/lemma2word.fst
fstrmepsilon ./FINALtransducers/lemma2word.fst ./FINALtransducers/lemma2word.fst
fstdeterminize ./FINALtransducers/lemma2word.fst ./FINALtransducers/lemma2word.fst
fstinvert ./FINALtransducers/lemma2word.fst ./FINALtransducers/word2lemma.fst

# Draw
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait ./FINALtransducers/lemma2noun.fst | dot -Tpdf  > ./FINALpdf/lemma2noun.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait ./FINALtransducers/lemma2adverb.fst | dot -Tpdf  > ./FINALpdf/lemma2adverb.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait ./FINALtransducers/lemma2verbip.fst | dot -Tpdf  > ./FINALpdf/lemma2verbip.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait ./FINALtransducers/lemma2verbis.fst | dot -Tpdf  > ./FINALpdf/lemma2verbis.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait ./FINALtransducers/lemma2verbif.fst | dot -Tpdf  > ./FINALpdf/lemma2verbif.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait ./FINALtransducers/lemma2verb.fst | dot -Tpdf  > ./FINALpdf/lemma2verb.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait ./FINALtransducers/lemma2word.fst | dot -Tpdf  > ./FINALpdf/lemma2word.pdf
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait ./FINALtransducers/word2lemma.fst | dot -Tpdf  > ./FINALpdf/word2lemma.pdf



#################################
# Test run 1
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test1.txt | fstarcsort > test1.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test1.fst | dot -Tpdf  > ./FINALexamples/test1.pdf
# Use the reverse fst of test1
fstreverse test1.fst > test1r.fst
fstcompose test1r.fst ./FINALtransducers/lemma2verb.fst > testresult1r.fst
# Reverse the result back to normal
fstreverse testresult1r.fst > test1_lemma2verb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test1_lemma2verb.fst | dot -Tpdf  > ./FINALexamples/test1_lemma2verb.pdf
# Print result
fstproject --project_output test1_lemma2verb.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 2
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test2.txt | fstarcsort > test2.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test2.fst | dot -Tpdf  > ./FINALexamples/test2.pdf
fstreverse test2.fst > test2r.fst
fstcompose test2r.fst ./FINALtransducers/lemma2verb.fst > testresult2r.fst
fstreverse testresult2r.fst > test2_lemma2verb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test2_lemma2verb.fst | dot -Tpdf  > ./FINALexamples/test2_lemma2verb.pdf
fstproject --project_output test2_lemma2verb.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 3
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test3.txt | fstarcsort > test3.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test3.fst | dot -Tpdf  > ./FINALexamples/test3.pdf
fstreverse test3.fst > test3r.fst
fstcompose test3r.fst ./FINALtransducers/lemma2verb.fst > testresult3r.fst
fstreverse testresult3r.fst > test3_lemma2verb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test3_lemma2verb.fst | dot -Tpdf  > ./FINALexamples/test3_lemma2verb.pdf
fstproject --project_output test3_lemma2verb.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 4
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test4.txt | fstarcsort > test4.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test4.fst | dot -Tpdf  > ./FINALexamples/test4.pdf
fstreverse test4.fst > test4r.fst
fstcompose test4r.fst ./FINALtransducers/lemma2word.fst > testresult4r.fst
fstreverse testresult4r.fst > test4_lemma2word.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test4_lemma2word.fst | dot -Tpdf  > ./FINALexamples/test4_lemma2word.pdf
fstproject --project_output test4_lemma2word.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 5
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test5.txt | fstarcsort > test5.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test5.fst | dot -Tpdf  > ./FINALexamples/test5.pdf
fstreverse test5.fst > test5r.fst
fstcompose test5r.fst ./FINALtransducers/lemma2word.fst > testresult5r.fst
fstreverse testresult5r.fst > test5_lemma2word.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test5_lemma2word.fst | dot -Tpdf  > ./FINALexamples/test5_lemma2word.pdf
fstproject --project_output test5_lemma2word.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 6
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test6.txt | fstarcsort > test6.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test6.fst | dot -Tpdf  > ./FINALexamples/test6.pdf
fstreverse test6.fst > test6r.fst
fstcompose test6r.fst ./FINALtransducers/lemma2word.fst > testresult6r.fst
fstreverse testresult6r.fst > test6_lemma2word.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test6_lemma2word.fst | dot -Tpdf  > ./FINALexamples/test6_lemma2word.pdf
fstproject --project_output test6_lemma2word.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 7
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test7.txt | fstarcsort > test7.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test7.fst | dot -Tpdf  > ./FINALexamples/test7.pdf
fstreverse test7.fst > test7r.fst
fstcompose test7r.fst ./FINALtransducers/word2lemma.fst > testresult7r.fst
fstreverse testresult7r.fst > test7_word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test7_word2lemma.fst | dot -Tpdf  > ./FINALexamples/test7_word2lemma.pdf
fstproject --project_output test7_word2lemma.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 8
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test8.txt | fstarcsort > test8.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test8.fst | dot -Tpdf  > ./FINALexamples/test8.pdf
fstreverse test8.fst > test8r.fst
fstcompose test8r.fst ./FINALtransducers/word2lemma.fst > testresult8r.fst
fstreverse testresult8r.fst > test8_word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test7_word2lemma.fst | dot -Tpdf  > ./FINALexamples/test8_word2lemma.pdf
fstproject --project_output test7_word2lemma.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# Test 9
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test9.txt | fstarcsort > test9.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test9.fst | dot -Tpdf  > ./FINALexamples/test9.pdf
fstreverse test9.fst > test9r.fst
fstcompose test9r.fst ./FINALtransducers/word2lemma.fst > testresult9r.fst
fstreverse testresult9r.fst > test9_word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test9_word2lemma.fst | dot -Tpdf  > ./FINALexamples/test9_word2lemma.pdf
fstproject --project_output test9_word2lemma.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt