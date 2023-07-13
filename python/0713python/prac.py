'''
problems = 'GDKKDGCCDDFDDGCCGCCGBDDGCCGFFGCCGCCGABGCCGCCG'
#위 문자열에서 GCCG의 위치 출력
#한 번 포함되면 포함된 문자를 빼고 찾기
#GCCGCCG는 1 번만 찾아냄
#hint: str.find, str.count

want = 'GCCGCCG'

idx = 0
answer = []
count = problems.count(want)
if count == 0:
    print(f"there's no {count} in {problems}", count, problems)
else:
    c = count
    while count:
        if idx == 0:
            idx = problems.find(want)
            answer.append(idx)
        else:
            idx += problems[idx +len(want):].find(want)
            idx += len(want)
            answer.append(idx)
        count -= 1
    print(f"there's total {c} {want} and locations are {answer}")

#---------------------------------
from collections import namedtuple
#자료구조 생성 - 튜플의 각 컬럼 이름 만들기
Person = namedtuple("Person", "name mobile")
persons = [Person('adam','010'), Person("jessica",'011')]
for person in persons:
    print(person.name)


#---------------------------------------------
#dict를 이용한 MVC
#DTO 역할 수행하는 class 생성 - 최근 권장
class DTO:
    def __init__(self, name = "noname", tel = "notel"):
        self.name = name
        self.tel = tel
    
#data 목록 생성
#datas = [DTO('adam', '010'), DTO('jessica','011')]

#이름과 전화번호 출력
#for data in datas:
#    print(data.name, data.tel)

#dict 목록 생성 - 예전 권장 <- key가 바뀌어도 다른 코드 변경 할 필요가 없기 때문
datas = [{"name":'adam', 'tel': '010'}, {'name':'jessica','tel':'011'}]
for data in datas:
    for key in data:
        print(key, ":",data[key])

        
#---------------------------------------------
#이차원 배열 대신 dict
kia = ["left","right"]
lg = ["u+","hv"]
hanhwa = ["bs"]


#kbo = [kia, lg] #list의 list
#list는 index 이용해서 접근, dict는 key 이용해서 접근
# -> dict 더 선호

#enumerate는 index와 data를 tuple로 return
#for idx, name in enumerate(kbo):
#    if idx == 0:
#        print("kia", end='\t')
#    else:
#        print("lg", end = '\t')

kbo = [{'team':'kia','data':kia},{'team':'team', 'data':lg}]
for dic in kbo:
    print(dic.get('team'),end='\t')
    for player in dic.get('data'):
        print(player,end='\t')
    print()

'''

'''
li = list(range(10))
#li의 모든 data를 제곱한 list 생성

#list comprehension - [연산식 순회할 문장]
result = [i**2 for i in li]
print(result)

#map 
result = list(map(lambda x: x**2, li))
print(result)

#list comprehension
#for 2개
li1 = [1,2,3]
li2 = [4,5,6,7]
result = [x*y for x in li1 for y in li2]
print(result)

#for 와 if 사용 가능 - filtering
singers= ['태연','수지','아이유','제이레빗']
#글자수 3 이상만 추출
result = list(filter(lambda x: len(x)>= 3, singers))
print(result)

#list comprehension - 더 빠른 방법 <- 함수는 별도의 공간 할당 받아 작업 수행후 return하기 때문
#2개의 조건 활용
result = [i for i in singers if len(i)>= 3 and i == '아이유']
print(result)

#if ~else for 사용
#3글자 이상은 그대로 나머지는 _ 추가
result = [i if len(i)>=3 else i+'_' for i in singers]
print(result)
'''
'''
from collections import Counter

data = ["한식", "중식","일식","일식","한식","한식"]
#data 목록을 가지고 데이터 개수 파악
counter = Counter(data)
#dict 변환해서 전체 data 개수 파악
print(dict(counter))
#한 가지 데이터 확인
print(counter['한식'])
#상위 두 개 만 추출
print(counter.most_common(2))


#tuple의 목록
data = [('APPLE',2),('APPLE',3),("ORANGE",3),('MANGO',3),('ORANGE',5)]
counter = Counter()
#data 합계 구하기
for name, count in data:
    counter[name] += count
print(counter)
#data 개수 구하기
counter = Counter()
for name, count in data:
    counter[name] +=1
print(counter)
'''

def div(x):
    return 10/x

try:
    print(div(20))
    print(div(0)) #예외 발생지
except:
    #try에서 문제가 발생하면 수행되는 구문
    print("예외 발생")
print("프로그램 종료")