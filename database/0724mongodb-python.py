#mongo db 사용을 위한 package import
from pymongo import MongoClient

#connect
conn = MongoClient('localhost', port = 27017)

#DB 사용설정
db = conn.mongo #없으면 생성 됨

#collection 설정
collect = db.data

# #insert data
# #삽입이나 삭제 또는 갱신을 하게 되면 결과를 return함
# result = collect.insert_one({"empno":"10001","name":"한글",
#                     "phone":"010-1234-1234","age":24})
# # print(dir(result)) #가지고 있는 fct, data 정보 확인
# print(result.acknowledged) #T/F return
# print(result.inserted_id)

# result = collect.insert_many([{"empno":"10002","name":"hi",
#                     "phone":"010-1234-4321","age":20},
#                     {"empno":"10003","name":"hello",
#                     "phone":"010-4321-1234","age":22}])
# print(result.acknowledged)
# print(result.inserted_ids) #many -> ids

#data 조회 -> cursor return
#result = collect.find()
#조건을 통과한 data만 추출해서 age를 기준으로 오름 차순 정렬 후 result에 저장
result = collect.find({'age':{'$gt':22}}).sort('age')
#print(dir(result)) # __iter__ 가짐 -> iterable = for 사용 가능
#cursor를 순서대로 접근하면 data가 dict로 접근 가능함
for temp in result:
    print(temp['name']) #없는 경우 팅김
    print(temp.get('name','이름 없음')) #data가 없는 경우 2번째 인자 값 return

#data 수정
collect.update_many(
    {'empno':'10001'},
    {'$set': {'name':'grace'}}
)