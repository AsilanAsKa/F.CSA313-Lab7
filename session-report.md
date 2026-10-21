# Exploratory Testing Report

**Тестер:** С. Асилан (B232270115)  
**Апп:** Уншлагын жагсаалт  
**Орчин:** Ubuntu 24.04, Node.js v22.22.2  
**Charter:** Ном нэмэх, хайх, устгах, статистик болон API шалгах.

## Автомат API тестийн бүртгэл

- Эхэлсэн цаг: 2026-10-21 16:41:57 +0800
- Дууссан цаг: 2026-10-21 16:41:57 +0800
- Үргэлжилсэн хугацаа: 0 секунд
- Үр дүн: `evidence/automated-api-tests.txt`
- Цагийн дэлгэрэнгүй бүртгэл: `evidence/automated-run-metadata.txt`

## Автомат тестээр ажигласан үр дүн

Exploratory Testing - API Checks
Run time: 2026-10-21 16:41:57 +0800

=== TEST 1: GET /api/books ===
[{"id":1,"title":"Тунгалаг Тамир","author":"Ч.Лодойдамба","year":1971},{"id":2,"title":"Clean Code","author":"Robert C. Martin","year":2008},{"id":3,"title":"The Pragmatic Programmer","author":"D.Thomas & A.Hunt","year":1999}]
PASS: GET /api/books returns HTTP 200
Books in list: 3

=== TEST 2: GET /api/stats ===
{"total":4,"newest":2008}
PASS: GET /api/stats returns HTTP 200
FAIL: Stats total matches number of listed books
Listed=3, stats total=4

=== TEST 3: Malformed JSON ===
HTTP/1.1 200 OK
Content-Type: application/json
Date: Wed, 21 Oct 2026 08:41:57 GMT
Connection: keep-alive
Keep-Alive: timeout=5
Transfer-Encoding: chunked

{"result":"OK"}
FAIL: Malformed JSON returns HTTP 400 (expected)

Summary: PASS=2 FAIL=2

## Илэрсэн асуудлууд

1. **BUG-01:** Буруу JSON хүсэлтэд HTTP 200 OK буцаасан. Нотолгоо: `evidence/bug-01-curl.txt`.
2. **BUG-02:** Хуучин хувилбарын холбоос HTTP 500 алдаа буцаасан. Нотолгоо: `evidence/bug-02-curl.txt`.
3. **BUG-03:** Номын жагсаалтад 3 ном байхад статистик `total: 4` буцаасан. Нотолгоо: `evidence/bug-03-curl.txt`.

## Хязгаарлалт

Энэ тайлан нь автомат API шалгалтын бүртгэл юм. Үүнийг 60 минутын хүний exploratory testing session гэж тооцоогүй. Бодит 60 минутын session-ийн эхлэх/дуусах цаг, ажиглалтын тэмдэглэл, цагийн задаргааг тухайн session-ийг хийсний дараа нэмнэ. UI screenshot хараахан бүртгэгдээгүй.
