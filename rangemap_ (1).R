

# https://marlonecobos.github.io/rangemap/

library(rangemap)
# packages to be used
library(raster)
library(maps)
library(maptools)
library(rangemap)
library(sf)
library(speciesgeocodeR)



# Simple graphical exploration of your data.
#The rangemap_explore function generates simple figures to visualize species occurrence data in the geographic space before using other functions of this package. The figure created with this function helps to identify countries involved in the species distribution. Other aspects of the species distribution can also be generally checked here; for instance, disjunct distributions, general dimension of the species range, etc.

#A small example
#Reading and exploring the species occurrence data
#Let's read the species records and check how the are geographically distributed using the rangemap_explore function.

housesparrow <- read.csv("/Users/srinidhi/R Files/rangemap biogeo/housesparrow.csv")
head(housesparrow)

roseata <- read.csv("G:\\d drive\\SACON\\Msc SACON\\Parakeets\\Psittacula roseata\\roseata.csv")

hornbill <- read.csv("/Users/srinidhi/R Files/rangemap biogeo/buceros_bicornis.csv")
head(hornbill)

crimson_sunbird <- read.csv("G:/d drive/SACON/Msc SACON/Crimson_sunbird.csv")
head(crimson_sunbird)

# simple figure of the species occurrence data
help(rangemap_explorer)
rangemap_explore(occurrences = housesparrow)
rangemap_explore(occurrences = hornbill)
rangemap_explore(occurrences = roseata)
rangemap_explore(occurrences = crimson_sunbird)

# simple figure of the species occurrence data
rangemap_explore(occurrences = housesparrow, show_countries = TRUE)

#Species ranges from buffered occurrences
#The rangemap_buff function generates a distributional range for a given species by buffering provided occurrences using a user-defined distance.

# species range
buff_range <- rangemap_buffer(occurrences = housesparrow, buffer_distance = 10000)

summary(buff_range)

#The function rangemap_plot generates customizable figures of species range maps using the objects produced by other function of this package.

rangemap_plot(buff_range)
rangemap_plot(buff_range, add_occurrences = TRUE,
              legend = TRUE, scalebar = TRUE, scalebar_length = 500, 
              zoom = 0.5, northarrow = TRUE)

# Species ranges from boundaries
#The rangemap_boundaries function generates a distributional range for a given species by considering all the polygons of administrative entities in which the species has been detected.

help(rangemap_boundaries)

#Using only occurrences
#Following there is an example in which administrative areas will be selected using only occurrences. The rangemap_explore function will be used for obtaining a first visualization of the species distributional range.

# checking which countries may be involved in the analysis
rangemap_explore(occurrences = housesparrow, show_countries = TRUE)

#Species ranges from hull polygons
#The rangemap_hull function generates a species range polygon by creating convex or concave hull polygons based on occurrence data.

#Convex hulls
#a species range will be constructed using convex hulls. After that this range will be split based on two distinct algorithms of clustering: hierarchical and k-means. Convex hull polygons are commonly used to represent species ranges, however in circumstances where biogeographic barriers for the species dispersal exist, concave hulls may be a better option.

# species range
hull_range <- rangemap_hull(occurrences = housesparrow, extent_of_occurrence = FALSE, area_of_occupancy = FALSE, hull_type = "convex", 
                            buffer_distance = 100000)

summary(hull_range)
rangemap_plot(hull_range, add_occurrences = TRUE,
              legend = TRUE, scalebar = TRUE, scalebar_length = 500, 
              zoom = 0.5, northarrow = TRUE)

# disjunct distributions
# clustering occurrences with the hierarchical method

# species range
hull_range1 <- rangemap_hull(occurrences = housesparrow, extent_of_occurrence = FALSE, area_of_occupancy = FALSE, hull_type = "convex", 
                             buffer_distance = 15000, split = TRUE, 
                             cluster_method = "hierarchical", 
                             split_distance = 15000)

summary(hull_range1)
rangemap_plot(hull_range1, add_occurrences = TRUE,
              legend = TRUE, scalebar = TRUE, scalebar_length = 500, 
              zoom = 0.5, northarrow = TRUE)

# clustering occurrences with the k-means method

# species range
hull_range2 <- rangemap_hull(occurrences = housesparrow, extent_of_occurrence = FALSE, area_of_occupancy = FALSE, hull_type = "convex", 
                             buffer_distance = 15000, split = TRUE, 
                             cluster_method = "k-means", n_k_means = 3)

summary(hull_range2)
rangemap_plot(hull_range2, add_occurrences = TRUE,
              legend = TRUE, scalebar = TRUE, scalebar_length = 500, 
              zoom = 0.5, northarrow = TRUE)

#Concave hulls
# The species range will be constructed using concave hulls. The species range will be calculated as an only area and as disjunct areas by clustering its occurrences using the k-means and hierarchical methods.

# species range
hull_range3 <- rangemap_hull(occurrences = housesparrow, extent_of_occurrence = FALSE, area_of_occupancy = FALSE, hull_type = "concave", buffer_distance = 15000)
summary(hull_range3)

rangemap_plot(hull_range3, add_occurrences = TRUE,
              legend = TRUE, scalebar = TRUE, scalebar_length = 500, 
              zoom = 0.5, northarrow = TRUE)


# disjunct distributions
# clustering occurrences with the hierarchical method

# species range
hull_range4 <- rangemap_hull(occurrences = housesparrow, extent_of_occurrence = FALSE, area_of_occupancy = FALSE, hull_type = "concave", 
                             buffer_distance = 15000, split = TRUE, 
                             cluster_method = "hierarchical", 
                             split_distance = 15000)

summary(hull_range4)
rangemap_plot(hull_range4, add_occurrences = TRUE,
              legend = TRUE, scalebar = TRUE, scalebar_length = 500, 
              zoom = 0.5, northarrow = TRUE)

# clustering occurrences with the k-means method

# species range
hull_range5 <- rangemap_hull(occurrences = housesparrow, extent_of_occurrence = FALSE, area_of_occupancy = FALSE, hull_type = "concave", 
                             buffer_distance = 15000, split = TRUE, 
                             cluster_method = "k-means", n_k_means = 3)
summary(hull_range5)
rangemap_plot(hull_range5, add_occurrences = TRUE,
              legend = TRUE, scalebar = TRUE, scalebar_length = 500, 
              zoom = 0.5, northarrow = TRUE)

