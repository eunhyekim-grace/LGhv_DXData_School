from django.shortcuts import render

# Create your views here.
#응답하는 class
from django.views import View
#Todo 모델
from .models import Todo
#JSON 응답을 만들기 위한 import
from django.http import JsonResponse
import json
from rest_framework import status

#날짜를 사용하기 위해서 import
import datetime

from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator

@method_decorator(csrf_exempt, name = 'dispatch')
#class의 get, post, put, delete method가 각 요청 방식을 처리
class TodoView(View):
    #get 요청 처리
    def get(self, request):
        #parameter 읽어오기
        #userid가 없으면 None return
        userid = request.GET.get('userid', None)
        if userid != None:
            todos = Todo.objects.filter(userid = userid)
        else:
            todos = Todo.objects.all()

        #list라는 key로 검색된 data를 list로 전달
        #return JsonResponse({'list':list(todos.values())}, 'message':'userid가 없음', status = status.HTTP_200_OK)
        return JsonResponse({'list':list(todos.values())}, status = status.HTTP_200_OK)
    
    #post 요청 처리
    def post(self, request):
        #parameter 읽기
        params = json.loads(request.body)
        userid = params['userid']
        title = params['title']

        #삽입할 객체 생성
        todo = Todo()
        todo.userid = userid
        todo.title = title
        todo.done = False
        todo.moddate = datetime.datetime.today()

        #저장
        todo.save()

        #삽입 후 결과 처리
        #일반적으로 삽입한 데이터만 return / 전체 데이터 return
        todos = Todo.objects.filter(userid = userid)
        #list라는 key로 검색된 data를 list로 전달
        return JsonResponse({'list':list(todos.values())}, status = status.HTTP_200_OK)
    
    def put(self, request):
        #client의 parameter 읽기
        params = json.loads(request.body)
        #변수 이름 = params['parameter 이름']
        id = params['id']
        userid = params['userid']
        done = params['done']

        #server에서의 처리
        #여기서 DB작업 이외의 작업을 한드면 별도의 class를 만들어서 처리한 후 return을 받아서 다음 작업을 수행
        #id에 해당하는 data를 찾아서 done의 값 수정하기
        todo = Todo.objects.get(id = id) #instance를 만들면 삽입, instance를 찾으면 수정
        todo.done = done
        todo.moddate = datetime.datetime.today()
        
        todo.save()

        #삽입 후 결과 처리
        #일반적으로 삽입한 데이터만 return / 전체 data return
        todos = Todo.objects.filter(userid = userid)
        #JSON 응답 list라는 키로 검색된 data를 list로 전달
        return JsonResponse({'list':list(todos.values())}, status = status.HTTP_200_OK)
    
    def delete(self, request):
        #parameter 읽기
        params = json.loads(request.body)
        id = params['id']
        userid = params['userid']

        #data 가져 오기
        todo = Todo.objects.get(id = id)
        #data 삭제
        todo.delete()

        #삭제 후 결과 처리
        #일반적으로 삽입한 데이터만 return / 전체 data return
        todos = Todo.objects.filter(userid = userid)
        #JSON 응답 list라는 키로 검색된 data를 list로 전달
        return JsonResponse({'list':list(todos.values())}, status = status.HTTP_200_OK)