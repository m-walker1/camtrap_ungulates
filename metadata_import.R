#after installing Exiftool windows executable
#identifying location of Exiftool

exiftool_location <- "C:/Strawberry/exiftool-11.10"
exiftoolPath(exiftoolDir = exiftool_location)

install.packages('camtrapR')
library(camtrapR)


#some Reconyx Hyperfire cameras need date/time adjusted: 

camtrap_images <- "R:/MT_camtrap_study/images"

fixDateTimeOriginal(inDir = camtrap_images,
                    recursive = TRUE)


#importing image metadata:
    #here, species ID is read from the metadata (IDfrom = 'metadata')
    #cameras are considered independent bc each camera is at a different station
    #the time difference between records of the same species at the same station 
      #to be considered independent is 5 minutes (minDeltaTime)
    #the time zone is Mountain Daylight Time (Montana)

metadata_table1 <-  recordTable(inDir = camtrap_images,
                                IDfrom = "metadata",
                                cameraID = "filename",
                                camerasIndependent = TRUE,
                                minDeltaTime = 5,
                                deltaTimeComparedTo = "lastRecord",
                                timeZone = "America/Denver",
                                metadataHierarchyDelimitor = "|",
                                removeDuplicateRecords = 'TRUE',
                                metadataSpeciesTag = "Species")



