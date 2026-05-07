# Tic Tac Toe on Laravel

## Dependencies

This project depends on Nix for reproducible builds and development 
environments. 

## Installation

```sh
nix develop
```

## Running

```sh
php artisan key:generate
php artisan migrate
php serve
```

## Testing

```sh
nix flake check
php artisan test
```
