from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view

from .serializers import BookSerializer
from rest_framework import status

from .models import Book

#GET 요청만 처리
@api_view(['GET']) #GET - 조회
def helloAPI(request): #request.get, request.post - 지정 가능, parameter 는 key,val로 형태가 고정 = dict
    return Response('Hello REST API')


# #POST 요청 처리
# @api_view(['POST'])
# def booksAPI(request):
#     #print("1") #출력 X -> url과 method 연결 실수 = urls.py의 url 설정에 오류
#     #client가 전송한 data를 모델이 사용할 수 있는 data로 변환
#     serializer = BookSerializer(data = request.data)
#     #print("2") #출력 X -> serializable 실패 = serializers.py와 models.py의 변수 이름이 맞지 않음
#     #유효성 검사
#     if serializer.is_valid():
#         #print("3") #출력 X -> 이름 잘못 입력  = web에서 입력할 때 실수한 것
#         serializer.save() #data 저장
#         #성공 했을 때 전송한 데이터를 다시 전송
#         return Response(serializer.data, status = status.HTTP_201_CREATED)
#     #실패했을 때 처리
#     return Response(serializer.errors, status= status.HTTP_400_BAD_REQUEST)

@api_view(['GET','POST'])
def booksAPI(request):
    #전송 방식을 확인하는 방법은 request.method를 확인하면 됨
    if request.method == 'GET':
        #전체 데이터 가져오기
        books = Book.objects.all()
        serializer = BookSerializer(books,many = True)
        return Response(serializer.data,status = status.HTTP_200_OK)
      
    elif request.method == 'POST':
        print(request.data)
        #client가 전송한 데이터를 모델이 사용할 수 있는 data로 변환
        serializer = BookSerializer(data = request.data)

        #유효성 검사
        if serializer.is_valid():
            serializer.save() #data 저장
            #성공 -> 전송한 데이터 다시 전송
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        #실패 ->처리
        return Response(serializer.errors, status= status.HTTP_400_BAD_REQUEST)

#기본키를 가지고 data를 1개 찾아오는데 없으면 404에러 발생
from rest_framework.generics import get_object_or_404

@api_view(['GET'])
def bookAPI(request, bid):
    #기본 키를 가지고 data 1개 가져오기
    book = get_object_or_404(Book, bid = bid)
    serializer = BookSerializer(book)
    return Response(serializer.data, status=status.HTTP_200_OK)

def ajax(request):
    return render(request, 'ajax.html')