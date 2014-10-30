<?php 

class Model extends ActiveRecord\Model{

	static $auto_increment = true;
	static $table_name = 'modelos';

	static $has_many = array(
		array('indicators', 'class_name' => 'Indicator', 'foreign_key' => 'id_modelo')
	);

}

?>