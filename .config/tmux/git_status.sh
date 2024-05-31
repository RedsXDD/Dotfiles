#!/usr/bin/env bash

cd "$1" || return 1

SYNC_MODE=0
NEED_PUSH=0

BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
if [[ "${#BRANCH}" -gt 25 ]]; then
	BRANCH="${BRANCH:0:25}…"
fi

STATUS="$(git status --porcelain 2>/dev/null | grep -cE "^(M| M)")"
if [[ "$STATUS" -ne 0 ]]; then
	DIFF_COUNTS=("$(git diff --numstat 2>/dev/null | awk 'NF==3 {changed+=1; ins+=$1; del+=$2} END {printf("%d %d %d", changed, ins, del)}')")
	CHANGED_COUNT="${DIFF_COUNTS[0]}"
	INSERTIONS_COUNT="${DIFF_COUNTS[1]}"
	DELETIONS_COUNT="${DIFF_COUNTS[2]}"

	SYNC_MODE=1
fi

UNTRACKED_COUNT="$(git ls-files --other --directory --exclude-standard | wc -l | bc)"

if [[ $CHANGED_COUNT -gt 0 ]]; then
	STATUS_CHANGED="#[none,bold,fg=color3] #[none,bold,fg=brightwhite]${CHANGED_COUNT} "
fi

if [[ $INSERTIONS_COUNT -gt 0 ]]; then
	STATUS_INSERTIONS="#[none,bold,fg=color2] #[none,bold,fg=brightwhite]${INSERTIONS_COUNT} "
fi

if [[ $DELETIONS_COUNT -gt 0 ]]; then
	STATUS_DELETIONS="#[none,bold,fg=color1] #[none,bold,fg=brightwhite]${DELETIONS_COUNT} "
fi

if [[ $UNTRACKED_COUNT -gt 0 ]]; then
	STATUS_UNTRACKED="#[none,bold,fg=color5] #[none,bold,fg=brightwhite]${UNTRACKED_COUNT} "
fi

# Determine repository sync status
if [[ $SYNC_MODE -eq 0 ]]; then
	NEED_PUSH="$(git log '@{push}..' | wc -l | bc)"
	if [[ $NEED_PUSH -gt 0 ]]; then
		SYNC_MODE=2
	else
		LAST_FETCH="$(stat -c %Y .git/FETCH_HEAD | bc)"
		NOW="$(date +%s | bc)"

		# if 5 minutes have passed since the last fetch
		if [[ "$((NOW - LAST_FETCH))" -gt 300 ]]; then
			git fetch --atomic origin --negotiation-tip=HEAD
		fi

		# Check if the remote branch is ahead of the local branch
		REMOTE_DIFF="$(git diff --numstat "${BRANCH}" "origin/${BRANCH}" 2>/dev/null)"
		if [[ -n "$REMOTE_DIFF" ]]; then
			SYNC_MODE=3
		fi
	fi
fi

# Set the status indicator based on the sync mode
case "$SYNC_MODE" in
1)
	REMOTE_STATUS="#[none,bold,fg=color11]󱓎"
	;;
2)
	REMOTE_STATUS="#[none,bold,fg=color1]󰛃"
	;;
3)
	REMOTE_STATUS="#[none,bold,fg=color5]󰛀"
	;;
*)
	REMOTE_STATUS="#[none,bold,fg=color2]"
	;;
esac

if [[ -n "$BRANCH" ]]; then
	BRANCH="${REMOTE_STATUS}#[none,bold,fg=brightwhite] ${BRANCH} "
	echo "| ${BRANCH}${STATUS_CHANGED}${STATUS_INSERTIONS}${STATUS_DELETIONS}${STATUS_UNTRACKED}"
fi

# vim:fileencoding=utf-8:foldmethod=marker
