library(readr)
mystring <- read_file("./spcData.txt")


file_info <- file.info("./spcData.txt")
file_size_bytes <- file_info$size
file_size_mb <- file_size_bytes / (1024^2)
znaku <- nchar(mystring)

hustotaDat <- znaku/file_size_mb

pocet <- ceiling(znaku /(hustotaDat*24))


for (i in 1:pocet) {
    print(c(hustotaDat*24*(i-1)+1, hustotaDat*24*i))
    split_strings <- substr(mystring, hustotaDat*24*(i-1)+1, hustotaDat*24*i)
    filename <- paste0("./Databaze/output", i, ".txt")
    writeLines(split_strings, filename)
}

