FROM php:8.3-fpm

# Instala dependências do PHP.
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Instala extensões do PHP.
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instala o Composer.
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho.
WORKDIR /var/www/html/laravel-app

# Copia o conteúdo da pasta laravel-app para o container.
COPY ./laravel-app /var/www/html/laravel-app

# Instala dependências do Composer.
RUN composer install --optimize-autoloader --no-dev

# Instala o Livewire.
RUN composer require livewire/livewire

# Ajusta permissões do Laravel.
RUN chown -R www-data:www-data /var/www/html/laravel-app/storage /var/www/html/laravel-app/bootstrap/cache
RUN chmod -R 777 /var/www/html/laravel-app/storage /var/www/html/laravel-app/bootstrap/cache

# Expõe a porta 9000 para o PHP-FPM.
EXPOSE 9000

# Roda o PHP-FPM.
CMD ["php-fpm"]