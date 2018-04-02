<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Settings extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('settings_model');
  }

  public function clo_options() {
    $cloOptions = $this->settings_model->get(array('name' => 'cloOptions'));

    while (!$cloOptions) {
      // insert default and return dat default
      $options = array(
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

      // json dat
      $content = json_encode($options);
      $data = array(
        'name' => 'cloOptions',
        'content' => $content,
        'updated_at' => time()
      );

      $res = $this->settings_model->insert($data);

      if (!$res) {
        $this->_json(FALSE);
      }

      // fetch again
      $cloOptions = $this->settings_model->get(array('name' => 'cloOptions'));
    }

    $cloOption = $this->_formatSettings($cloOptions)[0];
    $this->_json(TRUE, 'cloOptions', $cloOption);
  }

  public function syllabus_content() {
    $syllabusContent = $this->_getSyllabusContent();
    $this->_json(TRUE, 'syllabusContent', $syllabusContent);
  }

  public function update() {
    $name = $this->input->post('name');
    $content = $this->input->post('content');

    $data = array(
      'content' => $content,
      'updated_at' => time()
    );
    $where = array('name' => $name);

    $res = $this->settings_model->update($data, $where);
    $this->_json($res);
  }
}

?>
