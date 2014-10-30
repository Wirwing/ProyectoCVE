<?php 

class Activity extends ActiveRecord\Model{

	static $auto_increment = true;
	static $table_name = 'actividades_colaborativas';

	static $belongs_to = array(
    	array('model', 'foreign_key' => 'id_modelo', 'class_name' => 'Model')
	);

	static $delegate = array(
      array('indicators' => 'model')
    );

}

?>