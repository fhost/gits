if [ -n "$BASH_SOURCE" ]; then
    BASE="$(cd $(dirname $BASH_SOURCE) && pwd)"
elif [ -n "$ZSH_NAME" ]; then
    BASE="$(cd $(dirname $0) && pwd)"
else
    BASE="$(pwd)"
fi

export PATH=${BASE}/bin:${PATH}
export LCL_DIR=${BASE}

bitbake () {
	if [ ! -f conf/src-directory ]; then
		>&2 echo "error: this directory is not configured"
		return 1
	fi

	unset LC_ALL
	export LC_ALL
	export LANG=en_US.UTF-8
	export PATH=$(cat conf/src-directory)/oe-core/scripts:${PATH}
	export PATH=$(cat conf/src-directory)/bitbake/bin:${PATH}

	$(cat conf/src-directory)/bitbake/bin/bitbake $@
}
