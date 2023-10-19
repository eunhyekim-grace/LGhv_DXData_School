# Django

## Django 란
Python의 Web Application Framework

## 가상환경
프로그램을 독립적으로 실행할 수 있는 환경
```
> Windows 가상환경 설정
python3 -m venv {가상 환경 이름}
> 활성화
{가상 환경 이름}\Scripts\activate.bat
> Mac 가상환경 활성화
source {가상 환경 이름}/bin/activate
```

## Django 기본 설정
```
> 가상환경에 Django 설치
pip install django
> Django 프로젝트 설정
django-admin startproject pj이름 dir경로
> Django application 생성 - 실제 실행되는 프로그램 생성
python manage.py startapp {앱 이름}
> Data migration하기
python manage.py migrate
> Django application 실행
python manage.py runserver
> localhost:8000 에서 로켓 아이콘과 함께 successful 문구가 뜨면 기본 설정 완료
```

