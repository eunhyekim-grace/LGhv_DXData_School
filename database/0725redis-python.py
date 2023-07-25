import redis
import time

#Connection Pool을 이용한 접속
redis_pool = redis.ConnectionPool(host = 'localhost', port = 6379,
                                  max_connections = 4)

#db 접속
#with redis.StrictRedis(host = 'localhost', port = 6379) as conn:
with redis.StrictRedis(connection_pool=redis_pool) as conn:
    # #문자열 1개 저장
    # conn.set('name','제네시스')
    # #문자열 읽어오기 - bytes로 return
    # data = conn.get('name')
    # print(data) #인코딩 결과가 출력됨
    # print(data.decode('utf-8')) #디코딩 결과가 출력됨

    # #만료 시간 설정 가능
    # conn.set('name','adam', 10) #만료시간 = 10
    # #만료 시간 확인
    # print(conn.ttl('name'))

    # #생성 후 나중에 만료 시간 설정
    # conn.set('song','stay')
    # conn.expire('song',10) #data의 만료 시간 = 10
    # print(conn.get('song'))
    # time.sleep(20)
    # print(conn.get('song')) #20초 후에 데이터를 가져오므로 None return

    #list에 data 지정
    conn.lpush('album','genesis')
    conn.rpush('album','exodus')

    for album in conn.lrange('album',0,10):
        print(album)