# Assumption: DOI field preceeds URL field

BEGIN {
    FS  = "{"
    doi = ""
}

# save doi
/^\s*DOI =/ { 
    doi=$2
}

# drop URL if it is just https://doi.org/<DOI>
/^\s*URL =/ {
    if ( $2 == "https://doi.org/" doi )
	next
}

{print}
