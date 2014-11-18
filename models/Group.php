<?php

class Group extends ActiveRecord\Model{

  static $auto_increment = true;
  static $table_name = 'grupos_colaborativos';

  var $users_ids;

  static $has_many = array(
    array('group_users', 'class_name' => 'GroupUser'),
    array('users', 'class_name' => 'User', 'through' => 'group_users'),
  );

  static $after_create = array('set_users');

  public function set_users(){
    foreach ($this->users_ids as $user_id ) {
      $group_user_attr = array(
        'id_grupo' => $this->id,
        'id_usuario' => $user_id,
      );
      $groupUser = new GroupUser($group_user_attr);
      $groupUser->save();
    }
  }

}

?>
