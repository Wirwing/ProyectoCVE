<?php

class HabClass extends ActiveRecord\Model{

  static $auto_increment = true;
  static $table_name = 'clase';

  var $new_indicators;

  static $has_many = array(
    array('indicators', 'class_name' => 'Indicator', 'foreign_key' => 'class_id')
  );

  static $after_create = array('make_indicators');

  static $before_update = array('update_indicators');

  //Al actualizar una clase también se actualizan los indicadores hijos
  public function update_indicators(){

    if($this->new_indicators){
      foreach ($this->new_indicators as $indicator_attributes) {

        $indicator = Indicator::find($indicator_attributes["id"]);
        $indicator->update_attributes($indicator_attributes);

      }
    }
  }

  //Wraper: para cada indicador enviado como parametro en el constructor, se persisten en la bd.
  public function make_indicators() {
    if($this->new_indicators){
      foreach ($this->new_indicators as $indicator) {
        $this->create_indicator($indicator);
      }
    }
  }

}

?>
