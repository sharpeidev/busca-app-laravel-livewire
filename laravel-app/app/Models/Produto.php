<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Produto extends Model
{
    use HasFactory;

    protected $fillable = [
        'nome',
        'preco',
        'categoria_id',
        'marca_id',
    ];

    public function categoria() {
        return $this->belongsTo(Categoria::class);
    }

    public function marca() {
        return $this->belongsTo(Marca::class);
    }
}
