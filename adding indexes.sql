CREATE UNIQUE INDEX idx_methodist_email ON Methodist(email);

CREATE UNIQUE INDEX idx_teacher_email ON Teacher(email);

CREATE UNIQUE INDEX idx_student_email ON Student(email);

CREATE INDEX idx_course_name ON Course(course_name);
CREATE INDEX idx_course_relevance ON Course(relevance);

CREATE INDEX idx_lesson_course ON Lesson(course_id);

CREATE INDEX idx_onlineLesson_teacher ON OnlineLesson(teacher_id);

CREATE INDEX idx_student_course_student ON Student_Course(student_id);
CREATE INDEX idx_student_course_course ON Student_Course(course_id);

CREATE INDEX idx_homework_course ON Homework(course_id);
CREATE INDEX idx_homework_teacher ON Homework(teacher_id);

CREATE INDEX idx_student_homework_homework ON Student_homework(homework_id);

CREATE INDEX idx_homework_task_homework ON Homework_task(homework_id);

CREATE INDEX idx_task_possible_answer_answer ON Task_possible_answer(answer_id);

CREATE INDEX idx_student_answers_student ON Student_answers(student_id);
CREATE INDEX idx_student_answers_homework ON Student_answers(homework_id);
CREATE INDEX idx_student_answers_task ON Student_answers(task_id);