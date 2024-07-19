<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services. carajo no funciona como lo hago
     */
    public function boot(UrlGenerator $url)
    {
        $url->forceScheme('https');
    }
}
