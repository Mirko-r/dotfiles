#!/bin/bash
# feed() Save a feed in bookmarks ex: feed http://www.archlinux.org/feeds/news/ archnews
# deef() Read news from a bookmarks ex: deef archnews

if [ ! -n "$FEED_BOOKMARKS" ]; then export FEED_BOOKMARKS=$HOME/Bookmarks; fi
if [ ! -d "$FEED_BOOKMARKS" ]; then mkdir -p $FEED_BOOKMARKS; fi

feed() {
	if [ ! -d $FEED_BOOKMARKS ]; then mkdir $FEED_BOOKMARKS; fi

	if [ ! -n "$1" ]; then
		echo -e "\\n \\e[04mUsage\\e[00m\\n\\n   \\e[01;37m\$ feed \\e[01;31m<url>\\e[00m \\e[01;31m<new bookmark?>\\e[00m\\n\\n \\e[04mSee also\\e[00m\\n\\n   \\e[01;37m\$ deef\\e[00m\\n"
		return 1;
	fi

	local rss_source="$(curl --silent $1 | sed -e ':a;N;$!ba;s/\n/ /g')";

	if [ ! -n "$rss_source" ]; then
		echo "The feed is empty";
		return 1;
	fi

	# THE RSS PARSER
	# The characters "£, §" are used as metacharacters. They should not be encountered in a feed...
	echo -e "$(echo $rss_source | \
		sed -e 's/&amp;/\&/g
		s/&lt;\|&#60;/</g
		s/&gt;\|&#62;/>/g
		s/<\/a>/£/g
		s/href\=\"/§/g
		s/<title>/\\n\\n\\n   :: \\e[01;31m/g; s/<\/title>/\\e[00m ::\\n/g
		s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]/g
		s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
		s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
		s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
		s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
		s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
		s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
		s/<a[^§]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
		s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
		s/<!\[CDATA\[\|\]\]>//g
		s/\|>\s*<//g
		s/ *<[^>]\+> */ /g
		s/[<>£§]//g')\n\n";
	# END OF THE RSS PARSER

	if [ -n "$2" ]; then
		echo "$1" > $FEED_BOOKMARKS/$2
		echo -e "\\n\\t\\e[01;37m==> \\e[01;31mBookmark saved as \\e[01;36m\\e[04m$2\\e[00m\\e[01;37m <==\\e[00m\\n"
	fi
}

deef() {
	if test -n "$1"; then
		if [ ! -r "$FEED_BOOKMARKS/$1" ]; then
			echo -e "\\n \\e[01;31mBookmark \\e[01;36m\\e[04m$1\\e[00m\\e[01;31m not found.\\e[00m\\n\\n \\e[04mType:\\e[00m\\n\\n   \\e[01;37m\$ deef\\e[00m (without arguments)\\n\\n to get the complete list of all currently saved bookmarks.\\n";
			return 1;
		fi
		local url="$(cat $FEED_BOOKMARKS/$1)";
		if [ ! -n "$url" ]; then
			echo "The bookmark is empty";
			return 1;
		fi
		echo -e "\\n\\t\\e[01;37m==> \\e[01;31m$url\\e[01;37m <==\\e[00m"
		feed "$url";
	else
		echo -e "\\n \\e[04mUsage\\e[00m\\n\\n   \\e[01;37m\$ deef \\e[01;31m<bookmark>\\e[00m\\n\\n \\e[04mCurrently saved bookmarks\\e[00m\\n";
		for i in $(find $FEED_BOOKMARKS -maxdepth 1 -type f);
			do echo -e "   \\e[01;36m\\e[04m$(basename $i)\\e[00m";
		done;
		echo -e "\\n \\e[04mSee also\\e[00m\\n\\n   \\e[01;37m\$ feed\\e[00m\\n";
	fi;
}
