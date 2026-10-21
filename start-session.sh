#!/usr/bin/env bash
set -e
START=$(date +%s)
START_TEXT=$(date '+%Y-%m-%d %H:%M:%S %z')
mkdir -p evidence
echo "Session эхэллээ: $START_TEXT"
echo "Одоо exploratory testing хийж, ажиглалтаа evidence/session-notes.md файлд тэмдэглэ."
echo "60 минутын дараа энэ скрипт дуусахад session тайлангийн цаг автоматаар бичигдэнэ."
sleep 3600
END=$(date +%s)
END_TEXT=$(date '+%Y-%m-%d %H:%M:%S %z')
cat > evidence/session-time.txt <<EOT
Эхлэх цаг: $START_TEXT
Дуусах цаг: $END_TEXT
Үргэлжлэх хугацаа: $(((END-START)/60)) минут
EOT
cat evidence/session-time.txt
