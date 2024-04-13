<?php

namespace App\Http\Controllers;

use App\Enums\Permission;
use App\Enums\RoleType;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'email' => 'required|string|unique:users,email',
            'password' => 'required|string|confirmed'
        ]);

        $user = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => bcrypt($data['password'])
        ]);

        $role = Role::where('name', RoleType::CUSTOMER)->first();
        $user->roles()->attach($role);

        if ($user->hasRole(RoleType::SUPER_ADMIN)) {
            $user->givePermissionTo(Permission::SUPER_ADMIN);
        } elseif ($user->hasRole(RoleType::STORE_OWNER)) {
            $user->givePermissionTo(Permission::STORE_OWNER);
        } elseif ($user->hasRole(RoleType::STAFF)) {
            $user->givePermissionTo(Permission::STAFF);
        } else {
            $user->givePermissionTo(Permission::CUSTOMER);
        }

        $token = $user->createToken('apiToken')->plainTextToken;

        $response = [
            'user' => $user,
            'token' => $token
        ];
        return response($response, 201);
    }

    public function login(Request $request)
    {
        $data = $request->validate([
            'email' => 'required|string',
            'password' => 'required|string'
        ]);

        $user = User::where('email', $data['email'])->first();

        if (!$user || !Hash::check($data['password'], $user->password)) {
            return response([
                'msg' => 'incorrect username or password'
            ], 401);
        }

        $token = $user->createToken('apiToken')->plainTextToken;

        $response = [
            'user' => $user,
            'token' => $token
        ];

        return response($response, 200);
    }

    public function logout(Request $request)
    {
        if (auth()->user()) {
            auth()->user()->tokens()->delete();
        }

        return [
            'message' => 'User logged out.'
        ];
    }

}
