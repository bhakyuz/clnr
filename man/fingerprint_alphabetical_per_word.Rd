% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fingerprint_alphabetical_per_word.R
\name{fingerprint_alphabetical_per_word}
\alias{fingerprint_alphabetical_per_word}
\title{Find fingerprint of string which words are ordered alphabetically}
\usage{
fingerprint_alphabetical_per_word(s)
}
\arguments{
\item{s}{chacacter vector}
}
\value{
fingerprint of given vector in a character vector of same size 
class <- c("Class A","Class A", "A-CLASS", "A CLASS", "Class B","Class B", "B-CLASS", "B CLASS")
fingerprint_alphabetical_per_word(class)
}
\description{
Fingerprint in order to unify strings like 'Cat Dog' and 'Dog Cat'
}
