pager () { less -R -S; }

printfiles () {
    for x in $*
    do echo '################################################################################'
       echo "#### $x ####"
       echo '################################################################################'
       cat $x
       echo
    done
}

case $0 in
	*GL) git log --graph --abbrev-commit --pretty=oneline --decorate;;
	*SS) import -window root screenshot.jpg;;
	*xc) xclip -selection c $*;;
	*P) printfiles $* | pager;;
	*L) ls -F | column;;
	*r) at-git-root $*;;
	*E) $EDITOR $*;;
	*EE) $EDITOR $*;;
	*A) ag $* --pager P;;
	*f) gfmt -w81 | sed 's/\.   */\. /';;
	*order) gfmt -w1 | sort $* | gfmt -w81;;
	*summarize) P $(gwc -l $* | gsort -n | gsed 's/.*[0-9] //' | ghead -n-1);;
	*) echo wat $0 $*;;
	esac
