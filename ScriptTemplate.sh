#!/bin/sh

################################################################################
# Name           : ScriptTemplate.sh                                               #
# Author         : Kundan Chaulya                                              #
# Description    :                                                             #
# Exit Code      :                                                             #
#                                                                              #
# Change Control :                                                             #
#------------------------------------------------------------------------------#
# Version | Date(MM/DD/YYYY)| Author      | Description                        #
#------------------------------------------------------------------------------#
#                                                                              #
################################################################################

## Signal handlers
 # Signal 9 : SIGKILL or signal 9 (kill -9) cannot be trapped.
 # The kernel IMMEDIATELY terminates any process sent this signal and
 # no signal handling is performed.
 #
 # **** BE WARNED !!! Use SIGKILL as a last resort. ****
##

full_filename=$(basename "$0")
filename="${full_filename%.*}"
extension="${full_filename##*.}"
BIN_PATH=$(dirname "$0")

# Signal handlers
#trap exitFunc SIGHUP SIGINT SIGTERM INT
# Capture Ctrl+C
trap ctrl_c   INT      # Interrupt -- often CTRL-c
trap ctrl_d   QUIT     # Quit -- often CTRL-d
trap cmd_kill TERM     # From kill command
trap cmd_hup  HUP      # When session disconnected

#-------------------------------------------------------------------------------
#                      Function Definition - START                             #
#-------------------------------------------------------------------------------
##
 # Function to call for Ctrl+C
 # Input       : None
 # Return Code : None
 ##
function ctrl_c()
{
  WARN "** Trapped Ctrl+C !!! **"
  cleanUp
}

##
 # Function to call for Ctrl+d
 # Input       : None
 # Return Code : None
 ##
function ctrl_d()
{
  WARN "** Trapped Ctrl+d !!! **"
  cleanUp
}

##
 # Function to call for KILL
 # Input       : None
 # Return Code : None
 ##
function cmd_kill()
{
  WARN "** Trapped KILL !!! **"
  cleanUp
}

##
 # Function to call for HUP
 # Input       : None
 # Return Code : None
 ##
function cmd_hup()
{
  WARN "** Trapped HUP !!! **"
  cleanUp
}

##
 # Perform cleanup before exiting
 # Input       : None
 # Return Code : None
 ##
function cleanUp()
{
  # Perform program exit housekeeping
  INFO "Performing Clean-up ..."
  # TO DO : additional processing: send email
  # INFO "................................................................................"
  # INFO "                    Main (END)                                                  "
  # INFO "................................................................................"
  exit 9
}

##
 # Print formatted log message
 # Input       : Argument 1: Message to print
 # Return Code : None
 ##
function INFO()
{
  local msg="${1}"                # argument 1: message to print
  echo -e "$(date +'%Y-%m-%d %H:%M:%S') [INFO] ${filename}: $msg"
}

##
 # Print formatted log message
 # Input       : Argument 1: Message to print
 # Return Code : None
 ##
function WARN()
{
  local msg="${1}"                # argument 1: message to print
  echo -e "$(date +'%Y-%m-%d %H:%M:%S') [WARN] ${filename}: $msg"
}

##
 # Print formatted log message
 # Input       : Argument 1: Message to print
 # Return Code : None
 ##
function ERROR()
{
  local msg="${1}"              # argument 1: message to print
  echo -e "$(date +'%Y-%m-%d %H:%M:%S') [ERROR] ${filename}: ${msg}"
  echo -e "$(date +'%Y-%m-%d %H:%M:%S') [ERROR] ${filename}: EXITING"
  exit 1
}

##
 # Print usage
 # Input       : None
 # Return Code : None
 ##
function usage()
{
  echo -e "\n Usage:"
  echo "-------------------------------------"
  echo "$0 <Abs Path for log folder> <Abs path for payload file>"
  echo -e "\nDescription:"
  echo "____________________________"
  echo "TO DO"
  exit 1
}


##
 # Sends mail
 # Input       : Argument 1: From email
 #             : Argument 2: To mail
 #             : Argument 3: Subject
 #             : Argument 4: Message body
 # Return Code : None
 ##
function sendMail
{
  local from="${1}"
  local to="${2}"
  local subject="${3}"
  local message="${4}"
  
  (
    echo "From: ${from}";
    echo "To: ${to}";
    echo "Subject: ${subject}";
    echo "Content-Type: text/html";
    echo "MIME-Version: 1.0";
    echo "";
    echo "${message}";
  ) | sendmail -t

  return 0
}


#-------------------------------------------------------------------------------
#                      Function Definition - END                               #
#-------------------------------------------------------------------------------

# source "${CNF_DIR}/settings.cfg"
# source "${LIB_DIR}/DbLib.sh"
INFO "Param file $PARAM_FILE"

######################## __MAIN__ ###########################

INFO "-------------------- START - ${filename} --------------------"

# Your code logic here 

# Error handling
# if [ $? -ne 0 ] ; then
#   sendMail <<From>> <<TO-Mail>> <<Subject>> <<Message>>
#   ERROR "<<Error message>>"
#   exit 1
# else
#   INFO "send success mail"
#   sendMail $From $TO-Mail $Subject $Message
# fi

INFO "-------------------- END - ${filename} --------------------"

exit 0