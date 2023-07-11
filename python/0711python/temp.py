

import random
import time

li = ['오미크론','코로나','라투']
for i in range(10):
    time.sleep(1)
    #print(li[random.randint(0,len(li)-1)])

#정수 6개 받아서 오름차순 정렬
i = input("1~45까지 정수 공백으로 구분해서 6개 입력:")
x = i.split(' ')
lotto = list(map(lambda e: int(e),x))
#map(lambda e: int(e),x)
lotto.sort()
print(lotto)

#1~45까지 정수 
ar = range(1,46)
#t = random.sample(ar,6)
#cnt.sort()
#print(cnt)

cnt = 0
#1~45까지 숫자 중에 6개를 랜덤으로 추출, 몇 번째에 입력과 같아지는지
while True:
    prize = random.sample(ar, 6)
    prize.sort()
    cnt += 1
    if prize == lotto:
        break

print(cnt)

#li1 = [1,2,3]
#li2 = [1,2,3]
#print(li1 == li2) #list 안의 data 비교
#print(li1 is li2) #list의 id를 비교