import 'package:locket/models/post.dart';
import 'package:locket/models/user.dart';
import 'package:locket/responses/user_login.dart';

const Map<String, String> imageUrls = {
  'Giang': 'https://images.unsplash.com/photo-1719937051230-8798ae2ebe86?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'SonC': 'https://images.unsplash.com/photo-1726250864867-ad1dabb63c58?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'Hoang': 'https://images.unsplash.com/photo-1725055425170-474e60968d3e?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'MAH': 'https://images.unsplash.com/photo-1693087654826-f663e7cba602?q=80&w=2128&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',

};

Map<String, String> messages = {
  'Giang': 'ước được ai đó tặng',
  'SonC': 'So biu ti phun',
  'Hoang': 'my wife',
  'MAH': 'No Gay',

  // Add more messages for other names as needed
};

User giang = User(
  id: 1,
  firstName: 'Giang',
  lastName: 'Nguyen',
  phoneNumber: '0123456789',
  email: 'giang@gmail.com',
  address: 'Nghe An, Vietnam',
  password: '123',
  isActive: true,
  statusName: 'VERIFIED',
  dateOfBirth: '2004-01-01',
  avatarUrl: imageUrls['Giang'],
  roleName: 'USER',
  posts: List<Post>.empty(),
);

Post post = Post(
    userId: 1,
    title: 'ước được ai đó tặng',
    image: 'https://images.unsplash.com/photo-1719937051230-8798ae2ebe86?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
);

/*
{
	"tokenType": "Bearer",
	"id": 27,
	"username": "isa@gmail.com",
	"roles": [
		"ROLE_BREEDER"
	],
	"message": "Login successfully",
	"token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI3LCJlbWFpbCI6ImlzYUBnbWFpbC5jb20iLCJzdWIiOiJpc2FAZ21haWwuY29tIiwiZXhwIjoxNzM0Mjc0OTg3fQ.1of70QCz2YV3lQYxQPyMk_168gTmalLCcR0rN0X73Qw",
	"refresh_token": "b80352cb-d883-4c06-bbef-f15672fd79d3"
}
*/

UserLoginResponse userLoginResponse = UserLoginResponse(
  tokenType: 'Bearer',
  id: 27,
  username: 'hoang@',
  roles: ['ROLE_USER'],
  message: 'Login successfully',
  token: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI3LCJlbWFpbCI6ImlzYUBnbWFpbC5jb20iLCJzdWIiOiJpc2FAZ21haWwuY29tIiwiZXhwIjoxNzM0Mjc0OTg3fQ.1of70QCz2YV3lQYxQPyMk_168gTmalLCcR0rN0X73Qw',
  refreshToken: 'b80352cb-d883-4c06-bbef-f15672fd79d3'
);