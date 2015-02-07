pager () { less -R -S $*; }

case $0 in
	*GL) git log --graph --abbrev-commit --pretty=oneline --decorate;;
	*SS) import -window root screenshot.jpg;;
	*xc) xclip -selection c $*;;
	*P) case $# in 0) pager;; 1) pager $1;; *) more $* | pager;; esac;;
	*L) ls -F | column;;
	*r) at-git-root $*;;
	*E) $EDITOR $*;;
	*EE) $EDITOR $*;;
	*A) ag $* --pager P;;
	*f) fmt -w81 | sed 's/\.   */\. /';;
	*pj) ppjson;;
	*) echo wat $0 $*;;
	esac
