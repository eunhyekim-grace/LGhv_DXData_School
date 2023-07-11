import sys

sys.path.append('./') #현재 dir에서 모듈이나 package 검색하도록 설정

import mymath #mymath 모듈 import

print(mymath.MYPI)
mymath.func("모듈 사용")