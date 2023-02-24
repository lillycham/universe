#!/usr/bin/env fish

set folder $argv[1]
if not string length --quiet $argv
	set folder "results"
end

for file in $folder/*;
	perl -lne "
	/(?<=Executed\sin)\s+((([0-9]*[.])?[0-9]+)\s((micros)|(millis)|(secs)))/ &&
	print \$1" $file |\
	perl -lne "
	print \$_ / 1000 if ( /.*?(micros)/ );
	print \$_ * 1000 if ( /.*?(secs)/ );
	print \$_ + 0 if ( /.*?(millis)/ );
	" |\
	perl -lne "
	BEGIN {
	  \$total = 0.0;
	  \$count = 0;
	}
	
	END { 
		printf(\"%-20s %-10s %s\", (\$total / \$count), \"ms avg\", \"$file\");
	}

	while ( /(\d+\.?\d\d)/g ) {
	  \$count += 1;
	  \$total += \$1;
	}
	"
	printf "\n"
end | sort -V
