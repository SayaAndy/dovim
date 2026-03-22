<?php

use Movim\Migration;
use Illuminate\Database\Schema\Blueprint;

class ChangeAccentColorDefaultInUsersTable extends Migration
{
    public function up()
    {
        $this->schema->table('users', function (Blueprint $table) {
            $table->string('accentcolor')->default('green')->change();
        });
    }

    public function down()
    {
        $this->schema->table('users', function (Blueprint $table) {
            $table->string('accentcolor')->default('dorange')->change();
        });
    }
}
