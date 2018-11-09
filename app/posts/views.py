from django.shortcuts import render
from django.http import  HttpResponse
from .models import Posts
# Create your views here.
def index(request):
    #return HttpResponse('Hello from Posts')
    #return render(request,'posts/index.html')
    posts=Posts.objects.all()[:10]

    return render(request, 'posts/index.html',{'title':'Hello uday','knows':['python','php','node'],'posts':posts})

def details(request,id):
    post=Posts.objects.get(id=id)
    context={'post':post}
    return render(request,'posts/details.html',context)