from django.urls import path
from .views import *

urlpatterns = [
    path('upload_questions/', UploadQuestions.as_view(), name="Upload_Questions"),
    path('get_play_module_courses/', GetPlayModuleCourses.as_view(), name="Get_Play_Module_Courses"),
    path('get_play_module_course_subjects/', GetPlayModuleCourseSubjects.as_view(), name="Get_Play_Module_Course_Subjects"),
    path('get_play_module_subject_chapters/', GetPlayModuleSubjectChapters.as_view(), name="Get_Play_Module_Subject_Chapters"),
    path('get_play_module_courses_detail/', GetPlayModuleCoursesDetail.as_view(), name="Get_Play_Module_Courses_Detail"),
]