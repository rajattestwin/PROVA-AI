import io
import openpyxl
from rest_framework.views import APIView
from rest_framework.response import Response
from django.http.response import Http404
from django.db import transaction
from django.db.models import Count
import string 
import random as rd

from Content_app.models import *

# Create your views here.
@transaction.atomic
def create_course(institute, course_name, course_code, course_language):
    sid = transaction.savepoint()
    try:
        if course_code == None:
            prefix=  ''.join(rd.choices(course_name, k=5))
            suffix = ''.join(rd.choices(string.digits, k=4))
            course_code = prefix + '_' + suffix
        
        course = Course.objects.create(
            institute = institute,
            name = course_name,
            courseCode = course_code,
            courseLanguage = course_language
        )

        transaction.savepoint_commit(sid)

        return course

    except Exception as e:
        transaction.savepoint_rollback(sid)

        raise e

@transaction.atomic
def create_subject(course, subject_name, subject_code):
    sid = transaction.savepoint()
    try:
        if subject_code == None:
            prefix=  ''.join(rd.choices(subject_name, k=5))
            suffix = ''.join(rd.choices(string.digits, k=4))
            subject_code = prefix + '_' + suffix
        
        subject = Subject.objects.create(
            course = course,
            name = subject_name,
            subjectCode = subject_code
        )

        transaction.savepoint_commit(sid)

        return subject

    except Exception as e:
        transaction.savepoint_rollback(sid)

        raise e

transaction.atomic
def create_chapter(subject, chapter_name):
    sid = transaction.savepoint()
    try:
        chapter = Chapter.objects.create(
            subject = subject,
            name = chapter_name
        )

        transaction.savepoint_commit(sid)

        return chapter

    except Exception as e:
        transaction.savepoint_rollback(sid)

        raise e

class UploadQuestions(APIView):
    @transaction.atomic
    def post(self, request, *args, **kwargs):
        sid = transaction.savepoint()
        try:
            questions_file = request.FILES['questions_file']

            ques_related_data = request.data
            institute_name = ques_related_data['institute_name']
            sheet_name = ques_related_data['sheet_name']
            language = ques_related_data['language']
            chapter_name = ques_related_data['chapter_name']

            institute = Institute.objects.get(name=institute_name)

            questions_language = Language.objects.get(name=language)

            sheet_name_splitted = list(sheet_name.split('_'))
            course_name = sheet_name_splitted[0]
            subject_name = sheet_name_splitted[1]

            if Course.objects.filter(institute=institute, name=course_name, courseLanguage=questions_language).exists():
                course = Course.objects.get(
                    institute=institute,
                    name=course_name,
                    courseLanguage=questions_language
                )

            else:
                course = create_course(institute, course_name, None, questions_language)

            if Subject.objects.filter(course=course, name=subject_name).exists():
                subject = Subject.objects.get(
                    course=course,
                    name=subject_name
                )

            else:
                subject = create_subject(course, subject_name, None)

            if Chapter.objects.filter(subject=subject, name=chapter_name).exists():
                main_chapter = Chapter.objects.get(
                    subject=subject,
                    name=chapter_name
                )

            else:
                main_chapter = create_chapter(subject, chapter_name)

            wb = openpyxl.load_workbook(filename=io.BytesIO(questions_file.read()))
            ws = wb[sheet_name]

            for row in ws.iter_rows(min_row=3, values_only=True):
                if all(row[cell] is None for cell in range(len(row))):
                    break

                correct_option = row[1]
                question_statement = row[2]

                if row[6] or row[7]:
                    chapter, created = Chapter.objects.get_or_create(
                        subject = subject,
                        name = row[6] if row[6] else row[7]
                    )

                else:
                    chapter = main_chapter

                ques = Question.objects.create(
                    subject = subject,
                    chapter = chapter,
                    statement = question_statement,
                    quesLanguage = questions_language
                )

                option_choice = "A"

                for opt in range(15, 19):
                    if option_choice == correct_option:
                        is_correct = True
                    else:
                        is_correct = False

                    option = Option.objects.create(
                        ques = ques,
                        optionText = row[opt],
                        isCorrect = is_correct
                    )

                    option_choice = chr(ord(option_choice) + 1)

            context = {
                'status':'Success',
                'message':'Questions uploaded successfully!',
                'institute_name':institute_name
            }

            transaction.savepoint_commit(sid)

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

            transaction.savepoint_rollback(sid)

        return Response(context)

class GetPlayModuleCourses(APIView):
    def get(self, request, *args, **kwargs):
        try:
            institute_name = "TestWin"
            institute = Institute.objects.get(name=institute_name)

            courses = Course.objects.filter(
                institute=institute
            ).prefetch_related('courseLanguage')

            eng_courses_list = []
            hin_courses_list = []

            for course in courses:
                if course.courseLanguage.name == 'ENG':
                    eng_courses_list.append(course.name)

                else:
                    hin_courses_list.append(course.name)
            
            context = {
                'status':'Success',
                'message':'Here is play module courses!',
                'eng_courses':eng_courses_list,
                'hin_courses':hin_courses_list
            }

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

        return Response(context)

class GetPlayModuleCourseSubjects(APIView):
    def get(self, request, *args, **kwargs):
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')
            course_name = request.META.get('HTTP_COURSE_NAME')

            student = Student.objects.get(phoneNumber=phoneNo)

            institute_name = "TestWin"
            institute = Institute.objects.get(name=institute_name)

            student_language = Language.objects.get(studentsInParticularLanguage=student)

            course = Course.objects.get(
                institute=institute,
                name=course_name,
                courseLanguage=student_language
            )

            subjects = Subject.objects.filter(course=course)

            subjects_list = []

            for subject in subjects:
                no_of_subject_ques = Question.objects.filter(
                    subject=subject
                ).count()

                if no_of_subject_ques > 50:
                    subjects_list.append(
                        {
                            'subj_id':subject.id,
                            'subj_name':subject.name
                        }  
                    )
            
            context = {
                'status':'Success',
                'message':'Here is play module course subjects!',
                'course_name':course_name,
                'subjects':subjects_list
            }

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

        return Response(context)

class GetPlayModuleSubjectChapters(APIView):
    def get(self, request, *args, **kwargs):
        try:
            subject_id = request.META.get('HTTP_SUBJECT_ID')

            subject = Subject.objects.get(id=subject_id)

            chapter_ids_list = Chapter.objects.annotate(
                num_questions=Count('chapter_questions')
            ).filter(
                subject=subject,
                num_questions__gte=20
            ).values_list(
                'id', 
                flat=True
            )

            chapter_names_list = Chapter.objects.annotate(
                num_questions=Count('chapter_questions')
            ).filter(
                subject=subject,
                num_questions__gte=20
            ).values_list(
                'name', 
                flat=True
            )
            
            context = {
                'status':'Success',
                'message':'Here is play module subject chapters!',
                'course_name':subject.course.name,
                'subject_name':subject.name,
                'chapter_ids':chapter_ids_list,
                'chapter_names':chapter_names_list
            }

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

        return Response(context)

class GetPlayModuleCoursesDetail(APIView):
    def get(self, request, *args, **kwargs):
        try:
            institute_name = "TestWin"
            institute = Institute.objects.get(name=institute_name)

            courses = Course.objects.filter(
                institute=institute
            ).prefetch_related('courseLanguage')

            eng_courses_list = []
            hin_courses_list = []

            for course in courses:
                course_language = course.courseLanguage.name

                subjects = Subject.objects.filter(course=course)

                eng_subjects_list = []
                hin_subjects_list = []

                for subject in subjects:
                    no_of_subject_ques = Question.objects.filter(
                        subject=subject
                    ).count()

                    if no_of_subject_ques > 50:

                        chapter_ids_list = Chapter.objects.annotate(
                            num_questions=Count('chapter_questions')
                        ).filter(
                            subject=subject,
                            num_questions__gte=20
                        ).values_list(
                            'id', 
                            flat=True
                        )

                        chapter_names_list = Chapter.objects.annotate(
                            num_questions=Count('chapter_questions')
                        ).filter(
                            subject=subject,
                            num_questions__gte=20
                        ).values_list(
                            'name', 
                            flat=True
                        )

                        subject_dict = {
                            'subj_id':subject.id,
                            'subj_name':subject.name,
                            'chapter_ids':chapter_ids_list,
                            'chapter_names':chapter_names_list
                        }

                        if course_language == 'ENG':
                            eng_subjects_list.append(subject_dict)

                        else:
                            hin_subjects_list.append(subject_dict)

                if course_language == 'ENG':
                    eng_courses_dict = {
                        'course_id':course.id,
                        'course_name':course.name,
                        'subjects':eng_subjects_list
                    }

                    eng_courses_list.append(eng_courses_dict)

                else:
                    hin_courses_dict = {
                        'course_id':course.id,
                        'course_name':course.name,
                        'subjects':hin_subjects_list
                    }

                    hin_courses_list.append(hin_courses_dict)

            context = {
                'status':'Success',
                'message':'Here are play module courses details!',
                'eng_courses':eng_courses_list,
                'hin_courses':hin_courses_list
            }
            
        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

        return Response(context)
            
         