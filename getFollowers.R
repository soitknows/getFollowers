library(rtweet)

GetFollowerData <- function(user, pages) {
  i <- 1
  begin <- TRUE
  # Create output directory for Rdata output files.
  dir.create("output")
  # Empty list to store all data frames of followers.
  followers <- list()
  for (i in 1:pages) {
    if (begin == TRUE) {
      page <- -1
    }
    f <- get_followers(user, n = 75000, page = page)
    # Save each follower data frame object to an output file.
    filename <- paste("output/", "f", i, ".Rdata", sep = "")
    save(f, file = filename)
    # Append each follower data frame to followers list.
    followers[[i]] <- f
    # Store next cursor value to retrieve next page results after Sys.sleep.
    page <- next_cursor(f)
    begin <- FALSE
    # Wait 15 minutes before moving on to avoid API rate limit.
    Sys.sleep(15*60)
    i =+ 1
  }
  save(followers, file = "output/followers.Rdata")
}

# Get user data.
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1){
  stop("User must be specified.\n", call. = FALSE)
}
user <- args[1]
user_data <- lookup_users(user)
follower_count <- user_data$followers_count
# Calcualte followers page count.
if (follower_count %% 75000 == 0) {
  pages <- follower_count / 75000
} else {
  pages <- (follower_count %/% 75000) + 1
}
# Get followers and save the output.
GetFollowerData(user, pages)
