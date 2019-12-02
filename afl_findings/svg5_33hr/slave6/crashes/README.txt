Command line used to find this crash:

//home/stijn/Documents/University/Year_4/afl-2.52b/afl-fuzz -m none -i //home/stijn/Documents/University/Year_4/afl_testcases -o //home/stijn/Documents/University/Year_4/afl_findings/svg5 -S slave6 -- dot -O -Tsvg @@

If you can't reproduce a bug outside of afl-fuzz, be sure to set the same
memory limit. The limit used for this fuzzing session was 0 B.

Need a tool to minimize test cases before investigating the crashes or sending
them to a vendor? Check out the afl-tmin that comes with the fuzzer!

Found any cool bugs in open-source tools using afl-fuzz? If yes, please drop
me a mail at <lcamtuf@coredump.cx> once the issues are fixed - I'd love to
add your finds to the gallery at:

  http://lcamtuf.coredump.cx/afl/

Thanks :-)
