#!/usr/bin/env bash

BASE_URL="http://localhost:3000"
mkdir -p evidence
RESULT="evidence/automated-api-tests.txt"
PASS=0
FAIL=0

check() {
  if [ "$1" = "true" ]; then
    echo "PASS: $2"
    PASS=$((PASS + 1))
  else
    echo "FAIL: $2"
    FAIL=$((FAIL + 1))
  fi
}

{
  echo "Exploratory Testing - API Checks"
  echo "Run time: $(date '+%Y-%m-%d %H:%M:%S %z')"
  echo

  books=$(curl -sS --max-time 10 -w '\n%{http_code}' "$BASE_URL/api/books")
  books_code=$(printf '%s\n' "$books" | tail -n 1)
  books_body=$(printf '%s\n' "$books" | sed '$d')
  echo "=== TEST 1: GET /api/books ==="
  printf '%s\n' "$books_body"
  check "$([ "$books_code" = "200" ] && echo true || echo false)" \
    "GET /api/books returns HTTP 200"

  count=$(printf '%s' "$books_body" | node -e '
    let s=""; process.stdin.on("data",d=>s+=d);
    process.stdin.on("end",()=> {
      try { const a=JSON.parse(s); console.log(Array.isArray(a)?a.length:-1); }
      catch { console.log(-1); }
    });')
  echo "Books in list: $count"

  stats=$(curl -sS --max-time 10 -w '\n%{http_code}' "$BASE_URL/api/stats")
  stats_code=$(printf '%s\n' "$stats" | tail -n 1)
  stats_body=$(printf '%s\n' "$stats" | sed '$d')
  echo
  echo "=== TEST 2: GET /api/stats ==="
  printf '%s\n' "$stats_body"
  check "$([ "$stats_code" = "200" ] && echo true || echo false)" \
    "GET /api/stats returns HTTP 200"

  total=$(printf '%s' "$stats_body" | node -e '
    let s=""; process.stdin.on("data",d=>s+=d);
    process.stdin.on("end",()=> {
      try { console.log(JSON.parse(s).total); }
      catch { console.log(-1); }
    });')
  check "$([ "$count" = "$total" ] && echo true || echo false)" \
    "Stats total matches number of listed books"
  echo "Listed=$count, stats total=$total"

  malformed=$(curl -sS --max-time 10 -i \
    -X POST "$BASE_URL/api/books" \
    -H 'Content-Type: application/json' \
    --data-binary '{"title":')
  malformed_code=$(printf '%s\n' "$malformed" |
    awk '/^HTTP\// {code=$2} END {print code}')
  echo
  echo "=== TEST 3: Malformed JSON ==="
  printf '%s\n' "$malformed"
  check "$([ "$malformed_code" = "400" ] && echo true || echo false)" \
    "Malformed JSON returns HTTP 400 (expected)"

  echo
  echo "Summary: PASS=$PASS FAIL=$FAIL"
} 2>&1 | tee "$RESULT"

echo
echo "Evidence saved to: $RESULT"
