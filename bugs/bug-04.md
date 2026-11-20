# BUG-04: API статистикийн нийт номын тоо жагсаалттай зөрүүтэй

**Огноо:** 2026-11-20
**Аялал:** Saboteur
**Түвшин:** Major
**Төлөв:** Дахин баталгаажсан

## Орчны мэдээлэл
- Application: Reading List App
- API: localhost:3000
- Endpoint: GET /api/books, GET /api/stats

## Урьдчилсан нөхцөл
Серверийг зогсоож шинээр эхлүүлсэн. Анхны төлөвт 3 ном байна.

## Алхамууд
1. `GET /api/books` хүсэлт илгээх.
2. JSON массивын элементийн тоог тоолох.
3. `GET /api/stats` хүсэлт илгээх.
4. `total` утгыг жагсаалтын тоотой харьцуулах.

## Хүлээгдсэн үр дүн
`/api/stats` endpoint-ийн `total` утга `/api/books` endpoint-оос буцсан номын тоотой таарах ёстой.

## Бодит үр дүн
- `/api/books` 3 ном буцаасан.
- `/api/stats` `{"total":4,"newest":2008}` буцаасан.
- Хоёр endpoint HTTP 200 OK буцаасан.
- Нийт номын тоо 1-ээр илүү байна.

## Нотолгоо
- `evidence/bug-04-clean-state.txt` — цэвэр төлөвийн дахин баталгаажуулалт.
- `evidence/session-api-books.txt`
- `evidence/session-api-stats.txt`
