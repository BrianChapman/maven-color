WHITE=$(echo -en "\033[1;39m")
GREY=$(echo -en "\033[0;37m")
PURPLE=$(echo -en "\033[35m")
GREEN=$(echo -en "\033[32m")
RED=$(echo -en "\033[31m")
YELLOW=$(echo -en "\033[1;33m")
ORANGE=$(echo -en "\033[0;33m")
CYAN=$(echo -en "\033[1;36m")
BLUE=$(echo -en "\033[1;34m")
NORMAL=$(echo -en "\033[0m")

TEST_RUN="\(Tests run: [0-9]\+\)"
TEST_FAILURE="\(Failures: [1-9]\+\)"
TEST_ERROR="\(Errors: [1-9]\+\)"
TEST_SKIPPED="\(Skipped: [1-9]\+\)"
TEST_FAILURE_0="\(Failures: [0]\+\)"
TEST_ERROR_0="\(Errors: [0]\+\)"
TEST_SKIPPED_0="\(Skipped: [0]\+\)"
TEST_SEP="\(, \)"
TEST_FAILED="\(<<< FAILURE\!\)"


mvn-color() {
mvn $* | sed -e "s/^\(.ERROR. .*\)$/$RED\1$NORMAL/;          #contain ERROR start 2nd char
s/^\( \w*\\([\w\.]*\\).*: .*\)/$RED\1$NORMAL/;      # a name of method(name of class with package): error message
s/^\(|.*\)/$RED\1$NORMAL/;                          # line start with pipe
s/^\(### Content of table.*\)/$RED\1$NORMAL/;       # line start ### Content of table (dbunit)
s/^\(Caused by*.*\)/$RED\1$NORMAL/;                 # line start Caused by
s/^\(\tat .*\)/$RED\1$NORMAL/;                      # line start at ... (stack trace)
s/^\(\t*.*more.*\)/$RED\1$NORMAL/;                  # line start with tab and contain something with more (stack trace)
s/^\(##*.*\)/$RED\1$NORMAL/; # line start more than 1     #
s/^\(Running.*\)/$YELLOW\1$NORMAL/;                         # Line start with Running (surefire)

s/^\(.INFO. BUILD FAILURE.*\)$/$RED\1$NORMAL/;            # BUILD FAILURE
s/^\(.INFO. ----.*\)$/$WHITE\1$NORMAL/;                   # INFO of module block
s/^\(.INFO. Building.*SNAPSHOT\)$/$WHITE\1$NORMAL/;       # INFO of module block (with version)
s/^\(.INFO. --- .* ---.*\)$/$WHITE\1$NORMAL/;             # info of plugin
s/^\(.INFO. Reactor Summary:.*\)$/$WHITE\1$NORMAL/;       # INFO of module block (with version)
s/^\(.INFO. .*SUCCESS.*\)$/$WHITE\1$NORMAL/;       # INFO of module block (with version)
s/^\(.INFO. .*FAILURE.*\)$/$RED\1$NORMAL/;       # INFO of module block (with version)
s/^\(.INFO. .*\)$/$GREY\1$NORMAL/;                        # other info

s/^\(.WARNING. .*\)$/$ORANGE\1$NORMAL/;                   # warning

s/${TEST_RUN}/${GREEN}\1${NORMAL}/ ;  # test not failed
s/${TEST_FAILURE}/${RED}\1${NORMAL}/ ;  # test not failed
s/${TEST_ERROR}/${RED}\1${NORMAL}/ ;  # test not failed
s/${TEST_SKIPPED}/${YELLOW}\1${NORMAL}/ ;  # test not failed
s/${TEST_FAILED}/${RED}\1${NORMAL}/ ;#test failed.
s/^\(Failed tests:.*\)/$RED\1$NORMAL/;              # contain Failed tests: 

s/^\([^\[].*\)/${YELLOW}\1${NORMAL}/ ; # line doesn't start with [ 
" 
}

alias mvn='mvn-color'

