<?php

class GroupUser extends ActiveRecord\Model{

  static $auto_increment = true;
  static $table_name = 'grupos_colaborativos_usuarios';

  static $belongs_to = array(
    array('user', 'class_name' => 'User'),
    array('group', 'class_name' => 'Group')
  );

}

?>
