best <- function(state, outcome)
{
    outcome <- tolower(outcome)
    data <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
    data <- data[ ,c(2, 7, 11, 17, 23)]
    colnames(data) <- c('Hospital', 'State', 'heart attack', 'heart failure', 'pneumonia')
    if (state %in% data[, 2] == FALSE) {
        stop('invalid state')
    }
    if (outcome %in% colnames(data)[3:5] == FALSE) {
        stop('invalid outcome')
    }
    data <- data[data$State == state, c('Hospital', 'State', outcome)]
    data <- data[order(data$Hospital, decreasing = F), ]
    data[, 3] <- suppressWarnings(as.numeric(data[, 3]))
    return(data[which.min(data[, 3]), 1])
}

rankhospital <- function(state,outcome,num = "best")
{
    outcome <- tolower(outcome)
    data <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
    data <- data[ ,c(2, 7, 11, 17, 23)]
    colnames(data) <- c('Hospital', 'State', 'heart attack', 'heart failure', 'pneumonia')
    if (state %in% data[, 2] == FALSE) {
        stop('invalid state')
    }
    if (outcome %in% colnames(data)[3:5] == FALSE) {
        stop('invalid outcome')
    }
    data <- data[data$State == state, c('Hospital', 'State', outcome)]
    data <- data[order(data$Hospital, decreasing = F), ]
    data[, 3] <- suppressWarnings(as.numeric(data[, 3]))
    data <- data[complete.cases(data),]
    data <- data[order(data[,3], decreasing = F), ]
    if(num == "best")
        return(data[1,1])
    else if(num =="worst")
        return(data[nrow(data),1])
    else if(num > nrow(data))
        return(NA)
    else
        return(data[num,1])
}

rankall <- function(outcome ,num = "best")
{
    outcome <- tolower(outcome)
    rawData <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
    outcomeData <- rawData[ ,c(2, 7, 11, 17, 23)]
    colnames(outcomeData) <- c('Hospital', 'State', 'heart attack', 'heart failure', 'pneumonia')
    
    if (outcome %in% colnames(outcomeData)[3:5] == FALSE) {
        stop('invalid outcome')
    }
    
    
    selectData <- outcomeData[, c('Hospital', 'State', outcome)]
    selectData[, 3] <- suppressWarnings(as.numeric(selectData[, 3]))
    
    selectData <- selectData[complete.cases(selectData), ]
    
    selectData <- selectData[order(selectData$Hospital, decreasing = F), ]
    
    if (num == 'best') {
        selectData <- selectData[order(selectData[, 3], decreasing = F), ]
        rank <- 1
    } else if (num == 'worst') {

        selectData <- selectData[order(selectData[, 3], decreasing = T), ]
        rank <- 1      
    } else {
        selectData <- selectData[order(selectData[, 3], decreasing = F), ]
        rank <- num
    }
    

    splitData <- split(selectData[, c(1, 3)], selectData$State)
    hospital <- sapply(splitData, function(x) x[rank, 1])
    
    hospital <- data.frame(hospital)
    
    hospital$state <- row.names(hospital)
    
    
    return(hospital)
}