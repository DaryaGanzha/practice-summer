CREATE OR REPLACE FUNCTION random_between(min INTEGER, max BIGINT)
RETURNS BIGINT AS $$
BEGIN
  RETURN floor(random() * (max - min + 1) + min);
END;
$$ LANGUAGE plpgsql;

INSERT INTO Teacher (email, teacher_password, phone, user_role, teacher_first_name, teacher_last_name, date_of_birth, date_of_create)
SELECT DISTINCT ON (email)
  'teacher' || to_char(generate_series(1, 10), 'FM09') || '@example.com' AS email,
  md5(random()::text) AS teacher_password,
  to_char(random_between(1000000000, 9999999999), 'FM0000000000') AS phone,
  'teacher' AS user_role,
  substring(md5(random()::text) from 1 for 10) AS teacher_first_name,
  substring(md5(random()::text) from 1 for 10) AS teacher_last_name,
  timestamp '1960-01-01' + random() * (timestamp '2000-01-01' - timestamp '1960-01-01') AS date_of_birth,
  now() AS date_of_create
FROM generate_series(1, 10);

INSERT INTO Student (email, student_password, phone, user_role, student_first_name, student_last_name, date_of_birth, date_of_create)
SELECT DISTINCT ON (email)
  'student' || to_char(generate_series(1, 10), 'FM09') || '@example.com' AS email,
  md5(random()::text) AS student_password,
  to_char(random_between(1000000000, 9999999999), 'FM0000000000') AS phone,
  'student' AS user_role,
  substring(md5(random()::text) from 1 for 10) AS student_first_name,
  substring(md5(random()::text) from 1 for 10) AS student_last_name,
  timestamp '1995-01-01' + random() * (timestamp '2005-01-01' - timestamp '1995-01-01') AS date_of_birth,
  now() AS date_of_create
FROM generate_series(1, 10);

INSERT INTO Course (course_name, relevance, date_of_update, date_of_create, methodist_id, teacher_id)
SELECT DISTINCT ON (course_name)
  'Course ' || to_char(generate_series(1, 10), 'FM09') AS course_name,
  CASE WHEN random() > 0.5 THEN true ELSE false END AS relevance,
  now() - interval '1 day' * round(random() * 100) AS date_of_update,
  now() AS date_of_create,
  (SELECT methodist_id FROM Methodist ORDER BY random() LIMIT 1) AS methodist_id,
  (SELECT teacher_id FROM Teacher ORDER BY random() LIMIT 1) AS teacher_id
FROM generate_series(1, 20);

INSERT INTO Lesson (lesson_name, lesson_text, media, date_of_create, date_of_update, course_id)
SELECT DISTINCT ON (lesson_name)
  'Lesson ' || to_char(generate_series(1, 20), 'FM09') AS lesson_name,
  substring(md5(random()::text) from 1 for 100) AS lesson_text,
  CASE WHEN random() > 0.5 THEN 'media_file.mp4' ELSE NULL END AS media,
  now() AS date_of_create,
  now() - interval '1 day' * round(random() * 100) AS date_of_update,
  (SELECT course_id FROM Course ORDER BY random() LIMIT 1) AS course_id
FROM generate_series(1, 40);

INSERT INTO OnlineLesson (online_lesson_name, lesson_link, lesson_time, date_of_create, date_of_update, teacher_id)
SELECT DISTINCT ON (online_lesson_name)
  'Online Lesson ' || to_char(generate_series(1, 20), 'FM09') AS online_lesson_name,
  'https://zoom.us/meeting/' || to_char(random_between(100000000, 999999999), 'FM000000000') AS lesson_link,
  now() + interval '1 hour' * round(random() * 24) AS lesson_time,
  now() AS date_of_create,
  now() - interval '1 day' * round(random() * 100) AS date_of_update,
  (SELECT teacher_id FROM Teacher ORDER BY random() LIMIT 1) AS teacher_id
FROM generate_series(1, 40);

INSERT INTO Student_Course (subscribe_date, unsubscribe_date, student_id, course_id)
SELECT DISTINCT ON (student_id, course_id)
  now() - interval '1 day' * round(random() * 100) AS subscribe_date,
  CASE WHEN random() > 0.5 THEN now() - interval '1 day' * round(random() * 50) ELSE NULL END AS unsubscribe_date,
  s.student_id,
  c.course_id
FROM Student s
  CROSS JOIN Course c
WHERE random() < 0.2;

