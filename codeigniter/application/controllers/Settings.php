<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Settings extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('settings_model');
  }

  public function clo_options() {
    $cloOptions = $this->_getSettings('cloOptions');
    $this->_json(TRUE, 'cloOptions', $cloOptions);
  }

  public function syllabus_content() {
    $syllabusContent = $this->_getSettings('syllabusContent');
    $this->_json(TRUE, 'syllabusContent', $syllabusContent);
  }

  public function grading_system() {
    $gradingSystem = $this->_getSettings('gradingSystem');
    $this->_json(TRUE, 'gradingSystem', $gradingSystem);
  }

  public function update() {
    // image
    $img_src = FALSE;

    // upload image first
    // check if image exists
    if ($_FILES && $_FILES['file']) {
      $res = $this->_uploadFile();
      if (!$res['success']) {
        $this->_json(FALSE, 'error', strip_tags($res['error']));
      } else {
        $img_src = $res['data']['file_name'];
      }
    }

    $name = $this->input->post('name');
    $content = $this->input->post('content');

    // add img to content
    if ($img_src !== FALSE && $name == 'syllabusContent') {
      // convert content to json
      $contentObj = json_decode($content, TRUE);
      $contentObj['imgSrc'] = $img_src;

      // then convert contentObj to content string again
      $content = json_encode($contentObj);
    }

    $data = array(
      'content' => $content,
      'updated_at' => time()
    );
    $where = array('name' => $name);

    $res = $this->settings_model->update($data, $where);

    // insert trail
    if ($res) {
      $categories = array(
        'cloOptions' => 'clo_options',
        'gradingSystem' => 'grading_system',
        'syllabusContent' => 'syllabus_content'
      );
      $this->_insert_trail($categories[$name], 1);
    }

    $this->_json($res);
  }
}

?>
