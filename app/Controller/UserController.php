<?php declare(strict_types=1);

namespace App\Controller;

use App\Model\User;
use Hyperf\HttpServer\Contract\RequestInterface;

class UserController extends AbstractController
{
    public function index(RequestInterface $request)
    {
        return User::get();
    }

    public function show(string $id)
    {
        return User::find($id);
    }

    public function store(RequestInterface $request)
    {
        $parallel = new Parallel();

        foreach ($request->input('users') as $user) {
            $parallel->add(
                function () use ($user) {
                    User::create($user);
                },
                $user['id']
            );
        }

        return $parallel->wait();
    }

    public function delete(string $id)
    {
        return User::destroy($id);
    }
}
