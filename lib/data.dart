import 'package:locket/models/post.dart';
import 'package:locket/models/member.dart';
import 'package:locket/responses/user_login.dart';

Member everyoneData = Member(
    id: -1,
    firstName: '',
    lastName: '',
    nickname: 'Everyone',
    email: '',
    address: '',
    password: '',
    isActive: false,
    dateOfBirth: '',
    avatarUrl: null,
    roleName: '',
    posts: []
);

Member hoang = Member(
  id: 1,
  firstName: 'Hoang',
  lastName: 'Luu',
  nickname: 'lch',
  phoneNumber: '0123456789',
  email: 'giang@',
  address: 'Thanh Hoa, Vietnam',
  password: '123',
  isActive: true,
  statusName: 'VERIFIED',
  dateOfBirth: '2004-01-01',
  avatarUrl: 'https://images.unsplash.com/photo-1710988006558-3e57da46f7c0?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  roleName: 'ROLE_USER',
  posts: listPostHoang,
);

Member son = Member(
  id: 2,
  firstName: 'Son',
  lastName: 'Duong Cong',
  nickname: 'myhanh',
  phoneNumber: '0123456789',
  email: 'son@',
  address: 'Quanh Binh, Vietnam',
  password: '123',
  isActive: true,
  statusName: 'VERIFIED',
  dateOfBirth: '2004-01-01',
  avatarUrl: 'https://images.unsplash.com/photo-1710988073957-735265d25227?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  roleName: 'ROLE_USER',
  posts: listPostSon,
);

List<Post> listPostHoang = List.of([
  Post(
      id: 1,
      userId: 1,
      title: 'cong khai ny',
      image:
          'https://images.unsplash.com/photo-1685716851721-7e1419f2db18?q=80&w=1032&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
  Post(
      id: 2,
      userId: 1,
      title: 'buon ngu qua',
      image:
          'https://images.unsplash.com/photo-1725055425170-474e60968d3e?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
  Post(
      id: 3,
      userId: 1,
      title: 'thich anh nay',
      image:
          'https://images.unsplash.com/photo-1710988084343-03c28f267b7a?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
]);

List<Post> listPostSon = List.of([
  Post(
      id: 4,
      userId: 2,
      title: 'ước được ai đó tặng',
      image:
      'https://images.unsplash.com/photo-1719937051230-8798ae2ebe86?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
  Post(
      id: 5,
      userId: 2,
      title: 'bánh bao ngon',
      image:
      'https://scontent.xx.fbcdn.net/v/t1.15752-9/331998294_780585540165154_3899311870545398972_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=0024fc&_nc_ohc=6FnIa_OemxsQ7kNvgHeQOAj&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=scontent.xx&oh=03_Q7cD1QFBU7UkzuO4F8oAF3jnJSQJD2vFSECCntAeIK_14BoEuQ&oe=67689E6E'),
]);


UserLoginResponse hoangLoginResponse = UserLoginResponse(
    tokenType: 'Bearer',
    id: 27,
    member: hoang,
    roles: ['ROLE_USER'],
    message: 'Login successfully',
    token:
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI3LCJlbWFpbCI6ImlzYUBnbWFpbC5jb20iLCJzdWIiOiJpc2FAZ21haWwuY29tIiwiZXhwIjoxNzM0Mjc0OTg3fQ.1of70QCz2YV3lQYxQPyMk_168gTmalLCcR0rN0X73Qw',
    refreshToken: 'b80352cb-d883-4c06-bbef-f15672fd79d3'
);

UserLoginResponse sonLoginResponse = UserLoginResponse(
    tokenType: 'Bearer',
    id: 28,
    member: son,
    roles: ['ROLE_USER'],
    message: 'Login successfully',
    token:
    'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI3LCJlbWFpbCI6ImlzYUBnbWFpbC5jb20iLCJzdWIiOiJpc2FAZ21haWwuY29tIiwiZXhwIjoxNzM0Mjc0OTg3fQ.1of70QCz2YV3lQYxQPyMk_168gTmalLCcR0rN0X73Qw',
    refreshToken: 'b80352cb-d883-4c06-bbef-f15672fd79d3'
);