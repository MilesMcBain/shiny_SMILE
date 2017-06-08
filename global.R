# LIBRARIES

## Required
library(rJava)
library(tidyverse)

## Maybe Required
library(rChoiceDialogs)

# FUNCTIONS
source("./src/init_funcs.R")

# GLOBALS
# smile library and java wrapper from: https://download.bayesfusion.com/files.html?category=Academia
# Using x64 version
SMILE_jar_path <- "/home/miles/smile/smile.jar"
SMILE_dll_path <- "/home/miles/smile/libjsmile.so"

# Network defintion files
networks_path = file.path(getwd(), "networks")

# Init JVM and initialise smile library and classes 
.jinit(classpath = SMILE_jar_path, force.init = TRUE)
.jaddLibrary("jsmile", SMILE_dll_path)

# Create a new empty network
bayes_net <- .jnew("smile/Network")

# Get network file to load
network_definition <- select_local_networks(networks_path)

# Load network file
.jcall(obj=bayes_net, returnSig="V", method='readFile', network_definition)

# Construct a list of nodes in network
nodes_df <- get_network_nodes(bayes_net)

