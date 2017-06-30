records = LOAD 'input.txt' USING PigStorage('\n') AS (text:chararray);

hackathon = FOREACH records GENERATE 'hackathon' AS word, ((text matches '.*(?i)hackathon.*') ? 1 : 0) AS count;
hackathon_grouped = GROUP hackathon BY word;
hackathon_sum = FOREACH hackathon_grouped GENERATE group, SUM(hackathon.count);

Dec = FOREACH records GENERATE 'Dec' AS word, ((text matches '.*(?i)Dec.*') ? 1 : 0) AS count;
Dec_grouped = GROUP Dec BY word;
Dec_sum = FOREACH Dec_grouped GENERATE group, SUM(Dec.count);

Chicago = FOREACH records GENERATE 'Chicago' AS word, ((text matches '.*(?i)Chicago.*') ? 1 : 0) AS count;
Chicago_grouped = GROUP Chicago BY word;
Chicago_sum = FOREACH Chicago_grouped GENERATE group, SUM(Chicago.count);

Java = FOREACH records GENERATE 'Java' AS word, ((text matches '.*(?i)Java.*') ? 1 : 0) AS count;
Java_grouped = GROUP Java BY word;
Java_sum = FOREACH Java_grouped GENERATE group, SUM(Java.count);

result = UNION hackathon_sum, Dec_sum, Chicago_sum, Java_sum;
sorted_result = ORDER result BY $0;

STORE sorted_result INTO 'output' USING PigStorage(' ');
