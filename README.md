# getFollowers

getFollowers.R is an R script that can be used to gather all Twitter followers for a specified user. As the script runs each resulting data frame of 75,000 follwer ids is saved as an R object in an "output" directory. When the script completes a final data frame containing all follwer ids is also saved in the "output" directory.

For users with a large number of followers it's generally best fork the Rscript execution, as there is a 15 minute gap between each 75,000 users gathered (Twiiter API rate limit).


Example Usage

```
$ Rscript getFollwer.r realDonaldTrump
```

Example Output
```
$ f1.Rdata f2.Rdata f3.Rdata followers.Rdata
```