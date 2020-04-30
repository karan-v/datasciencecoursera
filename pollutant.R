pollutantmean <- function(directory,pollutant,id = 1:332)
{
    summ <- c()
    for(fileid in id)
    {
        file <- paste(directory, '/', formatC(fileid, width = 3, flag = "0"), '.csv', sep = "")
        file <- read.csv(file)
        summ <- append(summ,file[,pollutant])
    }
    return(mean(summ,na.rm=T))
}

complete <- function(directory,id=1:332)
{
    cases <- c()
    ids <- c()
    for(fileid in id)
    {
        ids <- append(ids,fileid)
        file <- paste(directory, '/', formatC(fileid, width = 3, flag = "0"), '.csv', sep = "")
        file <- read.csv(file)
        case_count <- sum(complete.cases(file))
        cases <- append(cases,case_count)
    }
    return(as.data.frame(cbind(ids,cases)))
}

corr <- function(directory,threshold=0)
{
    corr_vec = c()
    id = 1:332
    for(fileid in id)
    {
        file <- paste(directory, '/', formatC(fileid, width = 3, flag = "0"), '.csv', sep = "")
        file <- read.csv(file)
        if(sum(complete.cases(file))>threshold)
        {
            curr_corr <- cor(x = file[,'sulfate'],y = file[,'nitrate'],use = 'complete.obs')
            corr_vec = append(corr_vec,curr_corr)
        }
    }
    return(corr_vec)
}