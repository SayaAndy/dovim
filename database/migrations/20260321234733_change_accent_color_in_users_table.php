<?php

use Movim\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddAccentColorToUsersTable extends Migration
{
    public function up()
    {
        $this->schema->table('users', function (Blueprint $table) {
            $table->string('accentcolor')->default('green');
        });
    }

    public function down()
    {
        $this->schema->table('users', function (Blueprint $table) {
            $table->string('accentcolor')->default('dorange');
        });
    }
}
