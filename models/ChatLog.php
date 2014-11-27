<?php

class ChatLog extends ActiveRecord\Model{

  static $auto_increment = true;
  static $table_name = 'chat_logs';

  static $belongs_to = array(
    array('user', 'foreign_key' => 'id_usuario', 'class_name' => 'User'),
    array('indicator', 'foreign_key' => 'id_indicador', 'class_name' => 'Indicator')
  );

}

?>
