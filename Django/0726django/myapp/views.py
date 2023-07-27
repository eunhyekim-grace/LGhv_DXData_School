from django.shortcuts import render

from django.http import HttpResponse
from myapp.models import Item

# Create your views here.

# 요청을 처리하는 함수의 매개 변수는 request
# request 객체 안에는 client에 대한 정보다 저장되어 있음
def index(request):
    # print(dir(request))
    return HttpResponse("<p>Hello Django</p>")


def display(request):
    return render(request, "display.html")


def template(request):
    # msg = "Hello template"
    # person = {'name':"grace",'age': 24}
    age = 24
    data = ["Stack", "Queue", "Deque", "LinkedList", "Tree", "Graph", "Array"]
    # html에 데이터를 전송하고자 하면 세 번째 매개 변수에 dict를 만들어서 key, value 기재
    # return render(request, "template.html", {"msg" : msg, 'person':person})
    return render(request, "template.html", {"age": age, "data": data})


def sql(request):
    # data 1개 가져오기
    # data = Item.objects.get(itemid = '1')
    # data 전체 가져오기
    data = Item.objects.all()
    # data = Item.objects.filter(price = 300) #filter는 대소 조건 X
    # data = Item.objects.filter(itemid = '1')
    return render(request, "index.html", {"data": data})


def detail(request, itemid):
    item = Item.objects.get(itemid=itemid)
    print(item)
    return render(request, "detail.html", {"item": item})
