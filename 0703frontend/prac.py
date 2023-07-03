#Q1: print * like a shape below
#Q2: replace * with number 0~9 
'''
    *
   * *
  *   *
 *     *
*********
'''

#idea sketch - Q1
#total num = 9
#half = 5
#if draw middle line in idx = 5, 
#each sum of each side =4 except first and last row
#using only one for loop

#Q1 - A1
for i in range(4,0,-1):
    charstr = ''
    inside = 3-i
    charstr+=(" " * i)
    if inside < 0:
        print(charstr+"*"+"\n")
    else:
        charstr +=("*" + " "*((inside*2)+1)+"*")
        print(charstr+"\n")
print("*" *9)

#Q1 - A2
outside = 4
for i in range(0,4):
    charstr = ''
    if i == 0:
        charstr+=" " * outside
        outside -=1
        print(charstr+"*"+"\n")
    else:
        charstr+=(" "*outside + "*")
        charstr+=(" "*((i*2)-1) +"*")
        print(charstr+"\n")
        outside -=1
print("*" *9)

#Q2 = A1
num = 0
for i in range(4,0,-1):
    charstr = ''
    inside = 3-i
    charstr+=(" " * i)
    if inside < 0:
        print(charstr+str(num)+"\n")
        num+=1
    else:
        charstr +=(str(num) + " "*((inside*2)+1)+str(num+1))
        num+=2
        print(charstr+"\n")
l = [str((num+i)%10) for i in range(9)]
print(''.join(l))