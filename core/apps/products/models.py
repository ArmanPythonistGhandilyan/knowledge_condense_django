from django.db import models


class Foo(models.Model):
    name = models.CharField("Model nae", max_length=20)
    age = models.IntegerField("age")

    def __str__(self) -> str:
        return "foo_model"


class NewModel(models.Model):
    pass
