# Software security: Fuzzing project

# Goal:
# Run radamsa on testcases in tests/ 
# and run dot on every created file by radama.

# Number of files radamsa is going to make per test file.
runs=1000

# Output formats that dot will create.
outputformats=("pdf" "svg" "png" "jpg" "jpeg" "bmp" "json" )

# Successcode of dot. Any different code could result in a fuzzing success?
dot_successcode=23

# Directory administration
tests_dir="tests"
dir_prefix=created_
dir_dots=${dir_prefix}dots

# Create directories for .dot files created by radamsa.
# Create directories for every output format that dot is going to make.
mkdir -p $dir_dots
for i in "${outputformats[@]}"; do
  mkdir -p ${dir_prefix}${i}s
  mkdir -p ${dir_prefix}${i}s/fuzz_success/
done

# Variable to measure duration.
start=$SECONDS
declare -A durations

# Number of testcases
testcases=$(ls -1 --file-type tests/ | grep -v '/$' | wc -l)
# Run radamsa on /tests/*.dot files with runs times
echo "Creating $runs files on $testcases test cases with radamsa."
#for testfile_dir in "$tests_dir"/*
#do
#	testfile="${testfile_dir##*/}"
#	mkdir -p $dir_dots/$testfile
#	for ((ctr=1 ; ctr <= runs ; ctr++)); do
#		radamsa $testfile_dir > $dir_dots/$testfile/$ctr.dot
#  done
#done

duration=$(( SECONDS - start ))
echo "Radamsa created 1000 permutation files on every $testcases test cases in $duration".
start=$SECONDS

# Run dot on every .dot file randamsa created with every output file.
for format in "${outputformats[@]}"; do
	for dir in "$dir_dots"/*; do
		testfile=${dir##*/}
		mkdir -p ${dir_prefix}${format}s/$testfile
		echo $testfile
		for file in "$dir"/*; do	
			filename=${file##*/}
			echo "Running dot with format $format on file: $file"
		  dot -T${format} $file > ${dir_prefix}${format}s/$testfile/$filename.${format}
			test $? -gt 127 && mkdir -p ${dir_prefix}${format}s/fuzz_success/$testfile && 	mv ${dir_prefix}${format}s/$testfile/$filename.${format} ${dir_prefix}${format}s/fuzz_success/$testfile/$filename.${format}
#exitcode=$?
	#	  if [[ $exitcode -ne $dot_successcode ]]; then
	#	    mkdir -p ${dir_prefix}${format}s/fuzz_success/$testfile
	#	    mv ${dir_prefix}${format}s/$testfile/$filename.${format} ${dir_prefix}${format}s/fuzz_success/$testfile/$filename.${format}
	#	  fi
		done 
	done
	duration=$(( SECONDS - start ))
	durations[${format}]=$duration
	echo "Dot ran $duration seconds for output format $format."
	start=$SECONDS
done

for c in "${!durations[@]}"; do
	echo "Output format $c ran in ${durations[$c]} seconds."
done



