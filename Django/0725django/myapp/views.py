from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse


def index(request):
    # html을 직접 작성해서 출력
    # return HttpResponse("<h1>Hello Django</h1>")

    # html 파일 출력
    return render(request, "index.html")


def hello(request):
    return HttpResponse("<h3>Hello </h3>")
