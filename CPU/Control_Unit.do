force INST[7] 0 0, 1 6400 -repeat 12800
force INST[6] 0 0, 1 3200 -repeat 6400
force INST[5] 0 0, 1 1600 -repeat 3200
force INST[4] 0 0, 1 800 -repeat 1600
force INST[3] 0 0, 1 400 -repeat 800
force INST[2] 0 0, 1 200 -repeat 400
force INST[1] 0 0, 1 100 -repeat 200
force INST[0] 0 0, 1 50 -repeat 100

run 12800

force INST[7] 1 0
force INST[6] 0 0
force INST[5] 0 0
force INST[4] 1 0
force INST[3] 0 0
force INST[2] 0 0

force ZF 0 0, 1 50 -repeat 100

run 100

force INST[3] 0 0
force INST[2] 1 0

run 100

force INST[3] 1 0
force INST[2] 0 0
force OF 0 0, 1 100 -repeat 200
force NF 0 0, 1 200 -repeat 400

run 400

force INST[3] 1 0
force INST[2] 1 0
force OF 0 0, 1 50 -repeat 100
force NF 0 0, 1 100 -repeat 200

run 200