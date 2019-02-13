# Switch to Project Directory.
function p
{
    cd $PROJECTS_DIR/$1 2> /dev/null
    if [ $? -ne 0 ]; then
        echo "Project directory not found. Should I look in git repos?"
        read -p "Press enter to continue, CTRL^C to exit"
        REPO=`$DOTFILES/../bin/findRepo $1`

        if [ $? -eq 0 ]; then
            cd $PROJECTS_DIR
            git clone $REPO $1
            cd $PROJECTS_DIR/$1
        else
            echo "ERROR: No repository found for $1"
        fi
    fi
}
