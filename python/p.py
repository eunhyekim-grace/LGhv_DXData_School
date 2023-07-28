# N = 5
# stages = [2, 1, 2, 6, 2, 4, 3, 3]
# #[3,4,2,1,5]
# N = 4
# stages = [4,4,4,4,4]	
# #[4,1,2,3]

# from collections import Counter

# def solution(N, stages):
#     counter = Counter()
#     for i in stages:
#         counter[i] += 1
#     print(counter)
#     total = len(stages)
#     t = sorted(counter.items(), key = lambda pair: pair[0])
#     print(t)

#     cal = {}
#     for i in t:
#         key, val = i
#         cal[key] = val/total
#         total -= val
        
#     t_ = sorted(cal.items(), key = lambda pair: pair[1], reverse = True)
#     print(t_)

#     answer = [i[0] for i in t_]
#     print(answer)
#     if N+1 in answer:
#         answer.remove(N+1)
#     for i in range(1, N+1):
#         if i not in answer:
#             answer.append(i)
#     print(answer)


#     return 0

# solution(N, stages)

lst = [i for i in range(10)]

idx = lst.index(2)
lst[idx], lst[idx-1] = lst[idx-1], lst[idx]
print(lst)