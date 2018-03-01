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
  }

  public function _filter($str) {
    return strip_tags(trim(addslashes($str)));
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
      // parse all "content"
      foreach ($assigns as $key => $assign) {
        $assigns[$key]['content'] = json_decode($assign['content'], TRUE);
      }

      $created_by = $this->assigns_model->_to_col($assigns, 'created_by');
      // get "content"
      $content = $this->assigns_model->_to_col($assigns, 'content');
      $assigned = $this->assigns_model->_to_col($content, 'assigned');
      $courses = $this->assigns_model->_to_col($content, 'course');
      $subs = $this->assigns_model->_to_col($content, 'sub');

      // get "course" data
      $courseData = $this->assigns_model->getCoursesWithIds($courses);

      // convert $courseData to id => value instead of index => value
      $newCourseData = array();
      foreach ($courseData as $key => $course) {
        $newCourseData[$course['id']] = $course;
      }

      // users included in this fetch
      $subUsers = array();

      // $subs is an array of array of objects
      foreach ($subs as $key => $sub) {
        // $sub is an array of objects
        // add id to $subUsers
        foreach ($sub as $subkey => $value) {
          array_push($subUsers, $value['id']);
        }
      }

      $listedUsers = array_unique(array_merge($assigned, $subUsers, $created_by));

      // get all users with ids from $listedUsers
      $assignedUsers = $this->assigns_model->getUsersWithIds($listedUsers);
      
      // now these users are in index => value
      // make these as uid => value
      $newAssignedUsers = array();
      foreach ($assignedUsers as $key => $user) {
        $newAssignedUsers[$user['id']] = $user;
      }

      // now based on that, put those users in the "assigned" in $assigns
      foreach ($assigns as $key => $assign) {
        // add the course info
        $assigns[$key]['content']['course'] = $newCourseData[$assign['content']['course']];
        $assigns[$key]['content']['assigned'] = $newAssignedUsers[$assign['content']['assigned']];
        $assigns[$key]['created_by'] = $newAssignedUsers[$assign['created_by']];

        // also set "user" prop in "sub"
        foreach ($assign['content']['sub'] as $subkey => $sub) {
          // check if user exists
          if (array_key_exists($sub['id'], $newAssignedUsers)) {
            $assigns[$key]['content']['sub'][$subkey]['user'] = $newAssignedUsers[$sub['id']];
          }
        }
      }
      
    }

    return $assigns;
  }
}

?>
