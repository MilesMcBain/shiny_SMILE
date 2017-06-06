#Libraries

#Required
library(rJava)

#Maybe Required
library(rChoiceDialogs)

# GLOBALS
# smile library and java wrapper from: https://download.bayesfusion.com/files.html?category=Academia
# Using x64 version
SMILE_jar_path <- "C:/smile/smile.jar"
SMILE_dll_path <- "C:/smile/jsmile.dll"
# Network defintion files
networks_path = file.path(getwd(), "networks")

# Init JVM and initialise smile library and classes 
.jinit(classpath = SMILE_jar_path, force.init = TRUE)
.jaddLibrary("jsmile", SMILE_dll_path)

# Create a new empty network
bayes_net <- .jnew("smile/Network")

# Get network file to load
network_definition <- select_local_networks(networks_path)