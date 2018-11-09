#Creating Django Project
-------------------------
django-admin startproject djangoproject

#Running Server
-----------------
python manage.py runserver

#Migrate
-----------
python manage.py migrate


#Create Superuser
------------------
python manage.py createsuperuser --username=uday --email=shiuday@gmail.com


#Creating App
--------------
python manage.py  startapp posts

#and add on djangoproject/settings.py
INSTALLED_APPS=['posts',
..
]

#and add urlpatterns on  djangoproject/urls.py
#make sure you do : from django.urls import include
urlpatterns = [
    path('^$',include('posts.urls')),
    path('admin/', admin.site.urls),
    path('posts/',include('posts.urls'))
]

#create new file on posts/urls.py
from django.conf.urls import url
from . import views
urlpatterns = [
  url(r'^$',views.index,name='index')
]

#open posts/views.py and create index method
from django.shortcuts import render
from django.http import  HttpResponse
# Create your views here.
def index(request):
    #return HttpResponse('Hello from Posts')
    #return render(request,'posts/index.html')
    return render(request, 'posts/index.html',{'title':'Hello uday','knows':['python','php','node']})



#Create posts/templates/posts/index.html
{% extends "posts/layout.html" %}
{% block content %}
    <h2>{{title}}</h2>

You Know
<ul>
    {% for know in knows %}
    <li>{{know}}</li>
    {% endfor %}
</ul>
{% endblock %}






#Create posts/templates/posts/layout.html
<html>
<head>
    <title>Hello Layout</title>
</head>
<body>
<h1>Template extended</h1>
<div class="container">
    {% block content %}

    {% endblock %}
    </div>
</body>
</html>



#Creating Post Model
#Open file on posts/models.py
from django.db import models
from datetime import datetime


# Create your models here.
class Posts(models.Model):
    title=models.CharField(max_length=200)
    body=models.TextField()
    created_at=models.DateTimeField(default=datetime.now,blank=True)
    class Meta:
        verbose_name_plural='Posts'

    def __str__(self):
        return self.title


##Create migration for this model
python manage.py makemigrations posts
python manage.py migrate


#Register the Post Model on admin posts/admin.py
from django.contrib import admin

# Register your models here.
from .models import Posts

admin.site.register(Posts)


#List Post and Details From Db on posts view.py
def index(request):
    posts=Posts.objects.all()[:10]
    return render(request, 'posts/index.html',{'posts':posts})

def details(request,id):
    post=Posts.objects.get(id=id)
    context={'post':post}
    return render(request,'posts/details.html',context)


##Add urls on posts/urls.py
urlpatterns = [
  url(r'^$',views.index,name='index'),
url(r'^details/(?P<id>\d+)/$',views.details,name='details')
]


##Now Create View
###Create view for posts/templates/posts/index.html
<ul>
    {% for row in posts %}
    <li><a href="/posts/details/{{row.id}}">{{row.title}}</a></li>
    {% endfor %}
</ul>

###Create view for posts/templates/posts/detail.html

<h2>Details</h2>
{{post.title}}
{{post.created_at}}





