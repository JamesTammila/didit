import 'package:didit/domain/model/model_match.dart';
import 'package:didit/domain/model/model_post.dart';
import 'package:didit/domain/model/model_user.dart';

const mockMe = UserModel(
  objectId: '',
  createdAt: '',
  username: 'Jessie',
  proPicUri: 'https://i.pinimg.com/736x/78/4f/e8/784fe85e83e44328112af4298efdd9d6.jpg',
  friendState: 'ME',
  requestId: '',
);

List<MatchModel> mockMatches = [
  const MatchModel(
    objectId: '1',
    createdAt: '1',
    theme: 'Shoe Selfie',
    posts: [
      PostModel(
        objectId: '1',
        createdAt: '1',
        mediaUri:
        'https://i.pinimg.com/originals/4f/ea/17/4fea174592f4794c983ea0d1bf122428.jpg',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://i.pinimg.com/736x/a3/f6/91/a3f691a2c699fb79da00aace939b267b.jpg',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
      PostModel(
        objectId: '2',
        createdAt: '1',
        mediaUri:
        'https://t3.ftcdn.net/jpg/00/96/02/68/360_F_96026885_SQ4F1dlLFkVcoXlMaSwGVWKsIKJzDXaV.jpg',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://i.pinimg.com/736x/e0/21/8f/e0218f2b6a1d7c71f080749045233c63.jpg',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
      PostModel(
        objectId: '3',
        createdAt: '1',
        mediaUri:
        'https://s3.r29static.com/bin/entry/146/0,1463,3024,2268/x,80/1829672/image.jpg',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://data.whicdn.com/images/298487925/original.jpg?t=1534274746',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
      PostModel(
        objectId: '4',
        createdAt: '1',
        mediaUri:
        'https://st2.depositphotos.com/3978719/11406/i/600/depositphotos_114063400-stock-photo-close-up-of-legs-woman.jpg',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'Jessie',
          proPicUri:
          'https://i.pinimg.com/736x/78/4f/e8/784fe85e83e44328112af4298efdd9d6.jpg',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
    ],
  ),
  const MatchModel(
    objectId: '1',
    createdAt: '1',
    theme: 'Next Meal',
    posts: [
      PostModel(
        objectId: '5',
        createdAt: '1',
        mediaUri:
        'https://media-cdn.tripadvisor.com/media/photo-s/10/13/93/96/grigliata-mista.jpg',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://i.kym-cdn.com/photos/images/facebook/002/115/721/611.jpg',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
      PostModel(
        objectId: '6',
        createdAt: '1',
        mediaUri:
        'https://i.pinimg.com/736x/70/31/60/703160fa956b3d48a7c84d57e0a34088.jpg',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://play-lh.googleusercontent.com/bTjUXfgtmtC0G1xuKUAAlKoGQQAjlRc9it2rrOFakxLlNTdx16nbpMcR9VHNSSmoOw',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
      PostModel(
        objectId: '7',
        createdAt: '1',
        mediaUri:
        'https://i.pinimg.com/originals/92/d8/95/92d8956ba1256c436da36b6023ca8560.jpg',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://e1.pxfuel.com/desktop-wallpaper/534/172/desktop-wallpaper-stylish-people-to-follow-on-instagram-instagram-girl-profile-pic-thumbnail.jpg',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
      PostModel(
        objectId: '8',
        createdAt: '1',
        mediaUri:
        'https://i.pinimg.com/736x/13/66/7b/13667b785a9a649fab3100d27f9b2e35.jpg',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://techtrickseo.com/wp-content/uploads/2019/11/simmi.jpg',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
    ],
  ),
  const MatchModel(
    objectId: '1',
    createdAt: '1',
    theme: 'Favorite Dress',
    posts: [
      PostModel(
        objectId: '9',
        createdAt: '1',
        mediaUri:
        'https://flyingcdn-e81424e1.b-cdn.net/wp-content/uploads/2022/06/sabo.jpeg',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://i.pinimg.com/736x/2e/9a/bf/2e9abffabb021dede5067950ca490ea4.jpg',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
      PostModel(
        objectId: '10',
        createdAt: '1',
        mediaUri:
        'https://i0.wp.com/greenweddingshoes.com/wp-content/uploads/2022/05/boho-print-casual-summer-dresses.jpeg?fit=1024%2C9999',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://t3.ftcdn.net/jpg/02/96/66/58/360_F_296665879_g3GUJU6Vv9KzKkcNyaQ4uXEcCzRT6hSc.jpg',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
      PostModel(
        objectId: '11',
        createdAt: '1',
        mediaUri:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOckihnZP74NNzNlZGwcsyejezXZ2rG_kh9w&usqp=CAU',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://i.pinimg.com/736x/c8/83/0e/c8830e77b48ab4c55f478f1349ddc18c.jpg',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
      PostModel(
        objectId: '12',
        createdAt: '1',
        mediaUri:
        'https://i.etsystatic.com/32949567/r/il/bd85de/3958833269/il_fullxfull.3958833269_mmlu.jpg',
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPicUri:
          'https://i.pinimg.com/736x/5f/46/68/5f4668a11cf7a39a50900b3b47d2d392.jpg',
          friendState: 'RANDOM',
          requestId: '1',
        ),
      ),
    ],
  ),
];

List<UserModel> mockFriends = [
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Johanna',
    proPicUri: 'https://i.pinimg.com/736x/a3/f6/91/a3f691a2c699fb79da00aace939b267b.jpg',
    friendState: 'FRIEND',
    requestId: '1',
  ),
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'James',
    proPicUri: 'https://i.pinimg.com/736x/e0/21/8f/e0218f2b6a1d7c71f080749045233c63.jpg',
    friendState: 'FRIEND',
    requestId: '1',
  ),
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Jennifer',
    proPicUri: 'https://data.whicdn.com/images/298487925/original.jpg?t=1534274746',
    friendState: 'FRIEND',
    requestId: '1',
  ),
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Samantha',
    proPicUri:
    'https://qph.cf2.quoracdn.net/main-qimg-11d0c7a027d67e01bfd550dc0f0237da-lq',
    friendState: 'FRIEND',
    requestId: '1',
  ),
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Jacob',
    proPicUri:
    'https://i.kym-cdn.com/photos/images/facebook/002/115/721/611.jpg',
    friendState: 'FRIEND',
    requestId: '1',
  ),
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Hailey',
    proPicUri:
    'https://play-lh.googleusercontent.com/bTjUXfgtmtC0G1xuKUAAlKoGQQAjlRc9it2rrOFakxLlNTdx16nbpMcR9VHNSSmoOw',
    friendState: 'FRIEND',
    requestId: '1',
  ),
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Rihanna',
    proPicUri:
    'https://e1.pxfuel.com/desktop-wallpaper/534/172/desktop-wallpaper-stylish-people-to-follow-on-instagram-instagram-girl-profile-pic-thumbnail.jpg',
    friendState: 'FRIEND',
    requestId: '1',
  ),
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Janina',
    proPicUri:
    'https://i.pinimg.com/736x/2e/9a/bf/2e9abffabb021dede5067950ca490ea4.jpg',
    friendState: 'FRIEND',
    requestId: '1',
  ),
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Kiwoo',
    proPicUri:
    'https://i.pinimg.com/736x/5f/46/68/5f4668a11cf7a39a50900b3b47d2d392.jpg',
    friendState: 'FRIEND',
    requestId: '1',
  ),
];

List<UserModel> mockSuggestions = [
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Heather',
    proPicUri:
    'https://t3.ftcdn.net/jpg/02/96/66/58/360_F_296665879_g3GUJU6Vv9KzKkcNyaQ4uXEcCzRT6hSc.jpg',
    friendState: 'RANDOM',
    requestId: '1',
  ),
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Bernice',
    proPicUri:
    'https://i.pinimg.com/736x/c8/83/0e/c8830e77b48ab4c55f478f1349ddc18c.jpg',
    friendState: 'RANDOM',
    requestId: '1',
  ),
];

List<UserModel> mockRequests = [
  const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Niyah',
    proPicUri:
    'https://techtrickseo.com/wp-content/uploads/2019/11/simmi.jpg',
    friendState: 'PENDING',
    requestId: '1',
  ),
];