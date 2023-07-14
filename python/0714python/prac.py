''' 
#예외 처리

ar = range(10,31,10)


# 예외 발생 상황 - 0 division
try:
    su = int(input("나눌 수 입력: "))
    i = 0
    leng = len(ar)
    while i < leng:
        if su == 1:
            #강제로 예외 발생 시키기
            raise ValueError("강제로 예외 발생")
        #su의 값이 2라면 msg를 출력하고 프로그램은 중단 됩니다
        assert su != 2, 'su는 2이면 안됩니다'
        print(ar[i]/su)
        i += 1
except ValueError as e:
    print("잘못된 데이터 입력 에러")
    print(e)
except ZeroDivisionError as e:
    print("0으로 나눌 수 없음")
    print(e)
else:
    print("예외가 발생하지 않은 경우 수행할 내용")
finally:
    print("무조건 수행하는 문장")
'''
'''
#파일에 기록하기
import os
print(os.getcwd()) #상대 경로를 설정할 때 기준 경로

try:
    file = open('./text.txt','w', encoding= 'utf-8')
    file.write('문자열') #문자열 기록
    lines = ['김좌진','홍범도','김구']
    file.writelines(lines)
except Exception as e:
    print("파일 처리 중 예외 발생")
    print(e)
finally:
    file.close()
#파일 열어서 확인 - 한글 깨지면 open 함수에 encoding = '인코딩 방식'추가하기
'''
'''
#파일 읽기
import os
print(os.getcwd()) #상대 경로를 설정할 때 기준 경로

try:
    file = open('./text.txt','r', encoding= 'utf-8')
    #content = file.read() #전체 읽기
    #print(content)
    for line in file: #줄 단위 읽기
        print(line)
        print()
except Exception as e:
    print("파일 처리 중 예외 발생")
    print(e)
finally:
    file.close()
#파일 열어서 확인 - 한글 깨지면 open 함수에 encoding = '인코딩 방식'추가하기
'''
'''
#text file - with 사용
with open('./text.txt',encoding='utf-8') as file:
    for line in file: #줄 읽기
        print(line)
        print()
'''
'''
#csv file - text file로 읽어서 list로 변환
#마지막 data에는 \n이 추가 됨 -> 마지막 data의 \n 제거 필요
import re
import csv
data = []
with open('./text.csv', 'a',encoding='utf-8') as file:
    wr = csv.writer(file) 
    wr.writerow(['오늘은','금요일','해삐'])

print(data)

#줄 단위로 읽어서 list를 만들어 주는 reader 객체 생성
'''
'''
#binary file
data = []
with open('./text.bin', 'wb') as file:
    file.write("안녕하세요".encode())
with open('./text.bin', 'rb') as file:
    content = file.read()
    print(content.decode())
'''
'''
#serializable
class DTO:
    def __init__(self,num = 0, name = 'noname') -> None:
        #__이 붙으면 private 으로 class 안에서 생성되어 
        #class 안에서는  사용할 수 있지만 instance에서는 X
        self.__num = num 
        self.__name = name

    @property
    def num(self):
        return self.__num

    @property
    def name(self):
        return self.__name

    @name.setter
    def num(self, name):
        self.__name = name

    #instance를 print함수에 대입했을 때 호출되는 method - overriding
    #출력을 편리하게 하기 위해서 재정의 - 디버깅 목적
    def __str__(self):
        return str(self.__num) + ':' + self.__name


dto1 = DTO(1,'adam')
dto2 = DTO(2,'jessica')
data = [dto1, dto2]

import pickle
#try:
#    with open('./text.dat','wb') as file:
#        #f에 data를 serializable (직렬화)
#        pickle.dump(data,file)
#except Exception as e:
#    print(e)

try:
    with open('./text.dat','rb') as file:
        #f에 저장된 내용을 deserializable
        result = pickle.load(file)
        for dto in result:
            print(dto)
except Exception as e:
    print(e)
'''
'''
#zip file
import zipfile
#압축할 파일 목록 생성
filelist = ['./sources/text.dat', './sources/text.bin']
#파일 목록 순회하면서 압축
with zipfile.ZipFile('./sources/text.zip','w') as myzip:
    for temp in filelist:
        myzip.write(temp)

zipfile.ZipFile('./sources/text.zip').extractall()
'''

#응답 코드가 200인 data의 개수 세기
#IP 별 접속 횟수 세기 - 첫 번째 항목 IP
#IP 별 traffic 합계 - 마지막 항목 traffic
from collections import Counter
counter = Counter()
ipTraffic = {}
with open('./log.txt','r') as file:
    #읽어낸 한 줄을 공백을 기준으로 분할해서 list 생성
    for line in file:
        result = (line.split())
        try:
            #ipTraffic[result[0]] = ipTraffic.get(result[0],0)+int(result[-1])
            counter[result[0]] += int(result[-1])
        except:
            continue
        #using dict
        #dic[result] = dic.get(result,0)+1
    #for ip in ipTraffic:
    #    print(ip,":",ipTraffic[ip])
    for ip,num in counter.items():
        print(ip,":",num)
    #print(counter)

    help(dict.get)