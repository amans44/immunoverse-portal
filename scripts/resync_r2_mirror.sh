#!/usr/bin/env bash
#
# Refresh the Cloudflare R2 backup mirror from the NYU public asset share.
#
# Run this after Frank uploads a new batch of figures to NYU. It is INCREMENTAL:
# it lists NYU, lists R2, and transfers only the difference — so a routine top-up
# moves a few MB, not the full 7.5 GB.
#
# NYU is and remains the PRIMARY source. R2 is a byte-identical backup that the
# portal only reads when NYU does not respond (see ARCHITECTURE.md, "Secondary
# figure source"). Never upload figures straight to R2: they would exist only in
# the backup and so be invisible except during an NYU outage.
#
# Usage:
#   export R2_ACCOUNT_ID=d50100b70c1dac18162044694f4da4c9
#   export AWS_ACCESS_KEY_ID=...        # R2 API token, scoped to this bucket
#   export AWS_SECRET_ACCESS_KEY=...    # delete the token again when finished
#   bash scripts/resync_r2_mirror.sh
#
#   --dry-run   report what WOULD transfer, change nothing
#
# Requires: curl (>=7.66 for -Z) and the aws CLI. R2 is S3-compatible, so the
# aws CLI is only acting as an S3 client — no AWS account is involved.
set -uo pipefail

BASE="${BASE:-https://genome.med.nyu.edu/public/yarmarkovichlab/ImmunoVerse}"
SUB="${SUB:-assets}"
BUCKET="${BUCKET:-immunoverse}"
ENDPOINT="https://${R2_ACCOUNT_ID:?set R2_ACCOUNT_ID}.r2.cloudflarestorage.com"
PAR="${PAR:-12}"                 # parallel transfers; keep modest, NYU is someone else's server
DRY=0; [ "${1:-}" = "--dry-run" ] && DRY=1

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
log(){ printf '[%s] %s\n' "$(date +%H:%M:%S)" "$*"; }

# ---- 1. what NYU has -------------------------------------------------------
log "listing NYU $SUB/ ..."
curl -sS --max-time 600 "$BASE/$SUB/" -o "$WORK/listing.html" || { log "ERROR: cannot reach NYU"; exit 1; }
grep -oE 'href="[^"?][^"]*\.(png|svg)"' "$WORK/listing.html" \
  | sed 's/href="//;s/"//' | grep -v '^\./' | sort -u > "$WORK/nyu.txt"
log "  NYU: $(wc -l < "$WORK/nyu.txt") files"

# ---- 2. what R2 already has ------------------------------------------------
log "listing R2 s3://$BUCKET/$SUB/ ... (slow on ~200k objects)"
aws s3 ls "s3://$BUCKET/$SUB/" --endpoint-url "$ENDPOINT" --recursive \
  | awk '{ $1=""; $2=""; $3=""; sub(/^ +/,""); print }' \
  | sed "s#^$SUB/##" | sort -u > "$WORK/r2.txt"
log "  R2 : $(wc -l < "$WORK/r2.txt") objects"

# ---- 3. the difference -----------------------------------------------------
comm -23 "$WORK/nyu.txt" "$WORK/r2.txt" > "$WORK/new.txt"
comm -13 "$WORK/nyu.txt" "$WORK/r2.txt" > "$WORK/stale.txt"
NEW=$(wc -l < "$WORK/new.txt"); STALE=$(wc -l < "$WORK/stale.txt")
log "  NEW on NYU, missing from R2 : $NEW"
log "  in R2 but no longer on NYU  : $STALE  (left alone; delete by hand if intended)"

if [ "$NEW" -eq 0 ]; then log "mirror already current — nothing to do"; exit 0; fi
if [ "$DRY" -eq 1 ]; then log "--dry-run: stopping here"; head -20 "$WORK/new.txt" | sed 's/^/    /'; exit 0; fi

# ---- 4. fetch just the new files -------------------------------------------
# curl's own parallel mode via a config file. Do NOT use `export -f` + xargs
# here: the function does not survive into the subshells on Git-Bash/mingw and
# it silently fetches empty URLs.
mkdir -p "$WORK/dl"
: > "$WORK/curl.conf"
while IFS= read -r f; do
  [ -z "$f" ] && continue
  printf 'url = "%s/%s/%s"\noutput = "%s/dl/%s"\n' "$BASE" "$SUB" "$f" "$WORK" "$f" >> "$WORK/curl.conf"
done < "$WORK/new.txt"
log "downloading $NEW new files ..."
curl -sS -Z --parallel-max "$PAR" --fail --retry 3 --retry-delay 2 \
     --max-time 120 --connect-timeout 20 -K "$WORK/curl.conf" || true
GOT=$(find "$WORK/dl" -type f -size +0c | wc -l)
log "  downloaded $GOT / $NEW"

# ---- 5. push to R2 ---------------------------------------------------------
log "uploading to R2 ..."
aws s3 sync "$WORK/dl" "s3://$BUCKET/$SUB" --endpoint-url "$ENDPOINT" \
    --no-progress --only-show-errors
log "DONE — mirror refreshed with $GOT file(s)"
log "Remember to delete the R2 API token now that the sync is finished."
