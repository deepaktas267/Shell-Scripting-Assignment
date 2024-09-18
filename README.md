Write a shell script to change the values in a file(i.e sig.conf) according to the input passed to the script. The script should ask for all four inputs from the user & also validate the input.
Below are the details of input. In full bracket options are given, you have to restrict the user pass single value for each input from the provided options in the full bracket.
Input:-
1) Component Name [INGESTOR/JOINER/WRANGLER/VALIDATOR]
2) Scale [MID/HIGH/LOW]
3) View [Auction/Bid]
4) Count [single digit number]
Explanation of a conf file line.
<view> ; <scale> ; <component name> ; ETL ; vdopia-etl= <count>
Note:- vdopiasample stands for Auction & vdopiasample-bid is for Bid
The script should change the values in the file according to the input provided. At a time only one line of the conf file should be altered.
