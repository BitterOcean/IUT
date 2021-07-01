from django.contrib import admin
from django.urls import include, path
from demo1.views import demo1
from demo2.views import demo2

urlpatterns = [
    path('admin/', admin.site.urls),
    path('demo1/<str:data>', demo1, name='1st demo'),
    path('demo2/<str:username>/<str:password>', demo2, name='2nd demo'),
]
