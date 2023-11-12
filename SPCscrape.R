library("pdftools")
opendata <-read.csv2("./dlp.csv", stringsAsFactors = T) |>
    select(KOD_SUKL, NAZEV, DOPLNEK, SILA, FORMA, CESTA)
pdf_names <- read.csv2("./dlp_nazvydokumentu.csv") |>
    select(KOD_SUKL, SPC)

uplna_tabulka <- opendata |> 
    merge(pdf_names |> select(KOD_SUKL, SPC),
          by = c("KOD_SUKL", "KOD_SUKL"))

df<- uplna_tabulka |>
    select(NAZEV, SPC) |>
    distinct(NAZEV, .keep_all = T)


tt <- pdf_text(paste0("../SPC20230831/", df$SPC[1]))
tt |> str()
cat(tt[[3]])

ttt <- paste(tt, collapse = "\n")


df <- df |> mutate(m = nchar(SPC))
for (each in 1:nrow(df)){
        print(df$SPC[each])
    if (nchar(df$SPC[each]) < 16 & nchar(df$SPC[each]) !=0){
        tt <- try(pdf_text(paste0("../SPC20230831/", df$SPC[each])) |> paste(collapse = "\n"));
        df$SPC[each] <- tt
    }
}

df |> write.csv2("./spcDATA.csv")


library(jsonlite)



x <- toJSON(df)
sink("spcData.txt")
cat("const data = ")
cat(x)
sink()




opendata <-read.csv2("./dlp.csv", stringsAsFactors = T) |>
    select(KOD_SUKL, NAZEV, DOPLNEK, SILA, FORMA, CESTA)
df <- opendata |> mutate(Name = paste(NAZEV, DOPLNEK)) |> select(Name)


sink("doplnky.txt"); for (each in 1:nrow(df)){
    cat('<option value="', df$Name[each], '"></option>', sep = "")
}; sink()

<option value="ACYLCOFFIN"></option>
