<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class MY_Controller extends CI_Controller {
  public function __construct() {
    parent::__construct();
  }
}

/**
 * View Controller
 * 
 * Extend to this controller to load views.
 */
class MY_View_Controller extends MY_Controller {
  
  /**
   * Loads URL helper.
   */
  public function __construct() {
    parent::__construct();
    $this->load->helper('url');
  }

  /**
   * Loads a view in the views/ directory.
   *
   * @param mixed $view Name of the view or an array of names of the views in views/ to be loaded
   * @param mixed $data A string title for the view or an associative array to be passed in the $view
   * @param boolean $view_only Loads the $view only; otherwise, header and footer in views/templates/ are also loaded
   * @return void
   */
  protected function _view($view = 'pages/home', $data = array(), $view_only = FALSE) {
    $header = 'templates/header';
    $footer = 'templates/footer';

    // create array of views
    $views = array();

    // add header
    if (!$view_only) {
      array_push($views, $header);
    }

    // turn $view into array
    if (!is_array($title = $view)) {
      $view = array($view);
    }
    // add $view
    $views = array_merge($views, $view);

    // add footer
    if (!$view_only) {
      array_push($views, $footer);
    }

    // turn $data into array with title
    if (is_string($data)) {
      $data = array('title' => $data);
    }

    // set title if data is null or empty
    if (empty($data) && is_string($title)) {
      $data['title'] = ucfirst(basename($title));
    }

    // load $views
    foreach ($views as $index => $view) {
      // check if page exists
      if (!file_exists(APPPATH . 'views/' . $view . '.php')) {
        show_404();
      }
      // load view
      $this->load->view($view, $index === 0 ? $data : NULL);
    }

  }
}

/**
 * My custom controller
 * 
 * Extends MY_View_Controller
 */
class MY_Custom_Controller extends MY_View_Controller {
  public function __construct() {
    parent::__construct();
    // prevent access if not post request
    if ($this->input->method(TRUE) !== 'POST') {
      $this->_redirect();
    }
    // load lib
    $this->load->library('session');
    $this->load->model('logs_model');
  }

  public function _filter($str) {
    return strip_tags(trim(addslashes($str)));
  }

  public function _filter_bool($post, $default = FALSE) {
    return $this->input->post($post)
      ? filter_var($this->input->post($post), FILTER_VALIDATE_BOOLEAN)
      : $default;
  }

  public function _redirect($to = '../#/error') {
    redirect(base_url($to));
  }

  public function _json($success, $arr = array(), $val = NULL) {
    // if $arr is string, make it an array with $val
    if (is_string($arr)) {
      $arr = array($arr => $val);
    }

    $master = array_merge($arr, array('success' => $success));

    echo json_encode($master);
    exit;
  }

  public function _createAssigns($assigns) {
    if ($assigns) {
      $all_user_ids = array();
      $all_course_ids = array();

      foreach ($assigns as $key => $assign) {
        $content = $assigns[$key]['content'] = json_decode($assign['content'], TRUE);

        $created_by = $assign['created_by'];
        $assigned_id = $content['assigned']['id'];
        
        // just push and we'll remove duplicates later
        array_push($all_user_ids, $created_by);
        array_push($all_user_ids, $assigned_id);

        $levels = $content['levels'];
        foreach ($levels as $key => $level) {
          // $level is an array of objects
          foreach ($level as $lvl_key => $user) {
            array_push($all_user_ids, $user['id']);
          }
        }

        // get the course
        $course_id = $content['course'];

        array_push($all_course_ids, $course_id);
      }

      $all_user_ids = array_unique($all_user_ids);
      $all_course_ids = array_unique($all_course_ids);

      // fetch from db
      $all_users = $this->assigns_model->getUsersWithIds($all_user_ids);
      $all_courses = $this->assigns_model->getCoursesWithIds($all_course_ids);

      // yahoo we can now edit the assigns
      // create array of id => value users and courses
      $actual_users = array();
      foreach ($all_users as $key => $user) {
        $actual_users[$user['id']] = $user;
      }

      $actual_courses = array();
      foreach ($all_courses as $key => $course) {
        $actual_courses[$course['id']] = $course;
      }

      // loop through assigns again and set those values, baby
      foreach ($assigns as $key => $assign) {
        // set the info
        $assigns[$key]['content']['assigned']['user'] = $actual_users[$assign['content']['assigned']['id']];
        $assigns[$key]['content']['course'] = $actual_courses[$assign['content']['course']];
        $assigns[$key]['created_by'] = $actual_users[$assign['created_by']];

        // loop through levels
        foreach ($assign['content']['levels'] as $lvl_key => $level) {
          // loop through users
          foreach ($level as $u_key => $user) {
            $assigns[$key]['content']['levels'][$lvl_key][$u_key]['user'] = $actual_users[$user['id']];
          }
        }
      }
    }

    // get all user ids and put all dat in an array
    // using dat array, get all users
    // assign those users in assigned prop and all levels
    // same with courses

    // sample content structure
    // content = {
    //   assigned: { id, status },
    //   course: id,
    //   level: [
    //     [{ id, status }, ...],
    //     ...
    //   ]
    // }

    return $assigns;
  }

  public function _insertWorkflowLog($data) {
    $data['user_id'] = $this->session->userdata('user')['id'];
    $data['created_at'] = time();
    $data['status'] = 1;
    return $this->logs_model->insertWorkflow($data);
  }

  public function _formatUsers($users, $remove_password = FALSE) {
    if ($users) {
      foreach ($users as $key => $user) {
        if ($remove_password) {
          unset($users[$key]['password']);
        }
  
        $tags = json_decode($user['tags'], TRUE);
        $users[$key]['tags'] = is_array($tags) ? $tags : array();
        
        // make sure auth is all int
        $auth = json_decode($user['auth'], TRUE);
        $users[$key]['auth'] = is_array($auth) ? array_map('intval', $auth) : array();
      }
    }
    return $users;
  }

  public function _formatBooks($books) {
    if ($books) {
      foreach ($books as $key => $book) {
        $tags = json_decode($book['tags'], TRUE);
        $books[$key]['tags'] = is_array($tags) ? $tags : array();
      }
    }
    return $books;
  }

  public function _formatTopics($topics) {
    if ($topics) {
      foreach ($topics as $key => $topic) {
        $tags = json_decode($topic['tags'], TRUE);
        $topics[$key]['tags'] = is_array($tags) ? $tags : array();
      }
    }
    return $topics;
  }

  public function _formatOutcomes($arr) {
    if ($arr) {
      foreach ($arr as $key => $value) {
        $tags = json_decode($value['tags'], TRUE);
        $arr[$key]['tags'] = is_array($tags) ? $tags : array();
      }
    }
    return $arr;
  }

  public function _formatCurriculum($arr) {
    if ($arr) {
      foreach ($arr as $key => $value) {
        $content = json_decode($value['content'], TRUE);
        $arr[$key]['content'] = is_array($content) ? $content : array();
      }
    }
    return $arr;
  }

  public function _formatCourses($arr, $include_related = FALSE, $deep_include = FALSE) {
    if ($arr) {
      $prerequisite_ids = array();
      $corequisite_ids = array();

      foreach ($arr as $key => $value) {
        $tags = json_decode($value['tags'], TRUE);
        $arr[$key]['tags'] = is_array($tags) ? $tags : array();

        // add included and set them later
        if ($include_related) {
          
          $prerequisites = json_decode($value['prerequisites'], TRUE);
          if (is_array($prerequisites)) {
            $arr[$key]['prerequisites'] = $prerequisites;
            $prerequisite_ids = array_merge($prerequisite_ids, array_map('intval', $prerequisites));
          } else {
            $arr[$key]['prerequisites'] = array();
          }
          
          $corequisites = json_decode($value['corequisites'], TRUE);
          if (is_array($corequisites)) {
            $arr[$key]['corequisites'] = $corequisites;
            $corequisite_ids = array_merge($corequisite_ids, array_map('intval', $corequisites));
          } else {
            $arr[$key]['corequisites'] = array();
          }
          
        }
      }

      if ($include_related && (count($prerequisite_ids) || count($corequisite_ids))) {

        // combine pre and co requisites
        $all_ids = array_unique(array_merge($prerequisite_ids, $corequisite_ids));

        // load courses model
        $this->load->model('courses_model');
        $courses = $this->courses_model->getWhereIdIn($all_ids);
        
        if ($courses) {
          // format these courses too!
          $courses = $this->_formatCourses($courses, $deep_include, $deep_include);

          // make id => value
          $all_courses = array();
          foreach ($courses as $key => $value) {
            $all_courses[$value['id']] = $value;
          }

          // loop again in array
          foreach ($arr as $key => $value) {
            // loop through both pre and co requisites and set those
            foreach ($value['prerequisites'] as $arr_key => $id) {
              $arr[$key]['prerequisites'][$arr_key] = $all_courses[$id];
            }
            foreach ($value['corequisites'] as $arr_key => $id) {
              $arr[$key]['corequisites'][$arr_key] = $all_courses[$id];
            }
          }

        }
      }

    }
    return $arr;
  }

  public function _formatSettings($arr) {
    if ($arr) {
      foreach ($arr as $key => $value) {
        $arr[$key]['content'] = json_decode($value['content'], TRUE);
      }
    }
    return $arr;
  }

  public function _formatSyllabi($arr) {
    if ($arr) {
      foreach ($arr as $key => $value) {
        $arr[$key]['content'] = json_decode($value['content'], TRUE);
      }
    }
    return $arr;
  }

  public function _getPostLimit($limit_str = 'limit', $offset_str = 'offset', $raw = FALSE) {
    if (empty($this->input->post($limit_str))) {
      return FALSE;
    }

    $limit = (int) $this->input->post($limit_str);
    $page = $this->input->post($offset_str) ? $this->input->post($offset_str) : 0;
    
    if ($limit <= -1) {
      return FALSE;
    }

    $offset = ($page-1) * $limit;

    return $raw ? $limit : $limit * 2 + $offset;
  }
  

  private $_CLO_OPTIONS = array(
    array(
      'symbol' => 'I',
      'text' => 'Introductory'
    ),
    array(
      'symbol' => 'E',
      'text' => 'Engaging'
    ),
    array(
      'symbol' => 'D',
      'text' => 'Demonstrative'
    ),
  );

  private $_SYLLABUS_CONTENT = array(
    'institutionVision' => "FEU Institute of Technology aims to be one of the top five technology educational institutions in the Philippines.",
    'institutionMission' => "FEU Institute of Technology is dedicated to provide quality, relevant, innovative and industry-based education producing competent and principled professionals with greater sense of responsibility, social awareness and high competitiveness contributing significantly to the betterment of the society.",
    'departmentVision' => "The Information Technology Department aims its program specializations to be a catalyst on the delivery of industry-based standards solutions and internationally recognized IT education.",
    'departmentMission' => "The Information Technology Department is committed to provide industry-based information technology solutions, international academic linkages, researches and IT certified professionals.",
    'programEducationalObjectives' => "The graduates of the Bachelor of Science in Information Technology program are:\n1. engaged in further professional development and have interest in or aptitude for advanced studies or trainings in computing.\n2. entrepreneurs or are employed in computing industries, organizing and managing team-based projects leading to successful and sustainable computing systems solutions.\n3. responsible computing professionals actively participating in community groups that make a significant impact in addressing current and future societal challenges.",
    'imgSrc' => ""
  );

  private $_GRADING_SYSTEM = array(
    array(
      'label' => "Midterm Grade",
      'text' => "**Midterm Grade (MG) = 70% (Lecture Grade) + 30% (Lab Grade)**\n\n.\n\n**Lecture: 70%**\n\n- **Class Standing  (CS) 60%**\n\n    1. Average of at least two long quizzes 40%\n    2. Teacher’s Evaluation 5%\n    3. Class participation 25%\n        - (Seatwork, Assignments, Recitations)\n    4. Short Quizzes, Class Exercises 30%\n\n.\n\n**Midterm Exam (ME) 40%**\n\n.\n\n**Lab: 30%**\n\n- **Class Standing  (CS) 60%**\n    1. Laboratory Exercises/Machine Problems 40%\n    2. Teacher’s Evaluation 5%\n    3. Project/s 30%\n    4. Practical Exam  25%\n\n.\n\n**Midterm Exam (ME)\t40%**\n\n.\n\n.\n\n**PASSING RAW SCORE: 70**\n\n_Note:  Grades in Lecture and Lab should be the same._"
    ),
    array(
      'label' => "Final Grade",
      'text' => "**Final Grade (FG) = 70% (Lecture Grade) + 30% (Lab Grade)**\n\n.\n\n**Lecture: 70%**\n\n- **Class Standing  (CS) 60%**\n\n    1. Average of at least two long quizzes 40%\n    2. Teacher’s Evaluation 5%\n    3. Class participation 25%\n        - (Seatwork, Assignments, Recitations)\n    4. Short Quizzes, Class Exercises 30%\n\n.\n\n**Midterm Exam (ME) 40%**\n\n.\n\n**Lab: 30%**\n\n- **Class Standing  (CS) 60%**\n    1. Laboratory Exercises/Machine Problems 40%\n    2. Teacher’s Evaluation 5%\n    3. Project/s 30%\n    4. Practical Exam  25%\n\n.\n\n**Midterm Exam (ME)\t15%**\n\n**Final Exam (FE)\t25%**\n\n.\n\n**PASSING RAW SCORE: 70**\n\n_Note:  Grades in Lecture and Lab should be the same._"
    )
  );

  public function _getSettings($name) {
    $this->load->model('settings_model');
    $settings = $this->settings_model->get(array('name' => $name));

    while (!$settings) {
      $options = FALSE;
      if ($name == 'cloOptions') {
        $options = $this->_CLO_OPTIONS;
      } else if ($name == 'syllabusContent') {
        $options = $this->_SYLLABUS_CONTENT;
      } else if ($name == 'gradingSystem') {
        $options = $this->_GRADING_SYSTEM;
      }

      if (!$options) {
        $this->_json(FALSE);
      }

      // json dat
      $content = json_encode($options);
      $data = array(
        'name' => $name,
        'content' => $content,
        'updated_at' => time()
      );

      $res = $this->settings_model->insert($data);

      if (!$res) {
        $this->_json(FALSE);
      }

      // fetch again
      $settings = $this->settings_model->get(array('name' => $name));
    }

    $value = $this->_formatSettings($settings)[0];
    return $value;
  }

  public function _getMinor($version, $as_array = FALSE) {
    $arr = explode('.', $version);
    $arr[count($arr)-1] += 1;
    return $as_array ? $arr : implode('.', $arr);
  }

  public function _getMajor($version, $as_array = FALSE) {
    $arr = explode('.', $version);
    $arr[0] += 1;
    $arr[count($arr)-1] = 0;
    return $as_array ? $arr : implode('.', $arr);
  }

  public function _uploadFile($file_name = 'file', $allowed_types = FALSE, $path = 'uploads/images/') {
    if (!$allowed_types) {
      $allowed_types = 'jpg|png|jpeg';
    }

    $config = array(
      'upload_path' => './../'.$path,
      'allowed_types' => $allowed_types,
      'max_size' => 5*1000*1024,
      'file_name' => 'F_' . time()
    );

    $this->load->library('upload', $config);

    if (!$this->upload->do_upload($file_name)) {
      $error = $this->upload->display_errors();
      return array(
        'success' => FALSE,
        'error' => $error
      );
    }

    return array(
      'success' => TRUE,
      'data' => $this->upload->data()
    );
  }

  // logs

  private $_TRAIL_CATEGORIES = array(
    'user' => 1,
    'workflow_actions' => 2,
    'manage_users' => 3,
    'manage_courses' => 4,
    'manage_curriculum' => 5,
    'manage_outcomes' => 6,
    'manage_books' => 7,
    'syllabus_content' => 8,
    'grading_system' => 9,
    'clo_options' => 10,
    'workflow' => 11,
    'generator' => 12,
    'course' => 13,
    'syllabus' => 14,
    'profile' => 15
  );

  public function _insert_trail($category, $type, $extra = array()) {
    // if category does not exist
    if (!array_key_exists($category, $this->_TRAIL_CATEGORIES)) {
      return FALSE;
    }

    $uid = $this->session->userdata('user')['id'];
    $data = array(
      'user_id' => $uid,
      'created_at' => time(),
      'category' => $this->_TRAIL_CATEGORIES[$category],
      'type' => $type,
      'status' => 1
    );

    // merge with extra data
    $data = array_merge($data, $extra);
    return $this->logs_model->insertTrail($data);
  }

  public function _insert_userlog($type) {
    $uid = $this->session->userdata('user')['id'];

    return $this->logs_model->insertUserLog(array(
      'user_id' => $uid,
      'created_at' => time(),
      'type' => $type,
      'status' => 1
    ));
  }

  // generator commons

  public function _g_getTagsOfCourse($course_id, $tags = array()) {
    // get course
    $this->load->model('courses_model');
    $courses = $this->courses_model->getWhere(array('id' => $course_id));
    if (!$courses) {
      $this->_json(FALSE);
    }
    
    $course = $this->_formatCourses($courses)[0];
    $tags = array_merge($tags, $course['tags']);

    return $tags;
  }

  public function _g_getTagsOfBooks($books, $tags = array()) {
    // get books wherein title
    if ($books) {
      $this->load->model('books_model');
      $newBooks = $this->books_model->getWhereInCitation($books);
      $newBooks = $this->_formatBooks($newBooks);
      foreach ($newBooks as $key => $value) {
        $tags = array_merge($tags, $value['tags']);
      }
    }
    return $tags;
  }

  public function _g_getTagsOfTopics($topics, $tags = array()) {
    // get topics
    if ($topics) {
      $this->load->model('topics_model');
      $newTopics = $this->topics_model->getWhereInName($topics);
      $newTopics = $this->_formatTopics($newTopics);
      foreach ($newTopics as $key => $value) {
        $tags = array_merge($tags, $value['tags']);
      }
    }
    return $tags;
  }

  public function _updateSess() {
    $this->load->model('users_model');
    $uid = $this->session->userdata('user')['id'];
    $users = $this->users_model->get(array('id' => $uid));
    $user = $this->_formatUsers($users)[0];
    $this->session->set_userdata(array(
      'user' => $user,
      'auth' => $user['auth']
    ));
  }
}

?>
