from django.test import TestCase
from django.contrib.auth.models import User
from lists.models import TodoList


class TodoModelTest(TestCase):
    def test_create_todo(self):
        user = User.objects.create_user(username="artem")
        todolist = TodoList.objects.create(title="My List", creator=user)
        self.assertEqual(todolist.title, "My List")
        self.assertEqual(todolist.creator, user)