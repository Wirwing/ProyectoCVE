<?php

class User extends ActiveRecord\Model{

	static $table_name = 'usuarios';

	static $has_many = array(
		array('group_users', 'class_name' => 'GroupUser' )
	);

}

?>
