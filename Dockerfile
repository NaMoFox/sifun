# Utilizar la imagen oficial de PHP 8.0 con Apache y habilitar las extensiones necesarias
FROM php:8.0-apache

# Instalar extensiones adicionales necesarias para Laravel y sus dependencias
RUN docker-php-ext-install pdo pdo_mysql mbstring tokenizer xml zip

# Copiar el archivo de configuración de Apache
COPY --from=composer:latest /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/

# Copiar el archivo .env.example y configurar permisos
COPY .env.example /var/www/html/.env
RUN chmod -R 777 /var/www/html/.env

# Establecer la carpeta raíz de la aplicación
WORKDIR /var/www/html

# Copiar el código fuente de la aplicación (excluyendo vendor y node_modules)
COPY . /var/www/html/

# Instalar dependencias de Composer
RUN composer install --no-dev --prefer-source --ignore-platform-reqs

# Ejecutar migraciones y seeds de la base de datos
RUN php artisan migrate --force
RUN php artisan db:seed --force

# Cambiar permisos de la carpeta de almacenamiento
RUN chmod -R 777 /var/www/html/storage

# Exponer el puerto 80 para Apache
EXPOSE 80
