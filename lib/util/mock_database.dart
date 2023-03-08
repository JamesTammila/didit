import 'package:didit/model/model_post.dart';
import 'package:didit/model/model_media.dart';
import 'package:didit/model/model_user.dart';

const UserModel mockMe = UserModel(
  objectId: '',
  createdAt: '',
  username: 'Jessie',
  proPic: {
    'url':
        'https://i.pinimg.com/736x/78/4f/e8/784fe85e83e44328112af4298efdd9d6.jpg'
  },
  bio:
      'Future wife of big dick genius chad billionaire James Tammila, first of his name.',
);

const PostModel mockMatch = PostModel(
  objectId: '1',
  createdAt: '10:00',
  caption: 'Animals',
  medias: [
    MediaModel(
      objectId: '1',
      createdAt: '1',
      media: {
        'url':
            'https://i.pinimg.com/originals/4f/ea/17/4fea174592f4794c983ea0d1bf122428.jpg',
      },
      user: UserModel(
        objectId: '1',
        createdAt: '1',
        username: 'Johanna',
        proPic: {
          'url':
              'https://i.pinimg.com/736x/a3/f6/91/a3f691a2c699fb79da00aace939b267b.jpg'
        },
        bio: 'Slut',
      ),
    ),
    MediaModel(
      objectId: '1',
      createdAt: '1',
      media: {
        'url':
            'https://i.pinimg.com/originals/4f/ea/17/4fea174592f4794c983ea0d1bf122428.jpg',
      },
      user: UserModel(
        objectId: '1',
        createdAt: '1',
        username: 'Johanna',
        proPic: {
          'url':
              'https://i.pinimg.com/736x/a3/f6/91/a3f691a2c699fb79da00aace939b267b.jpg',
        },
        bio: 'Slut',
      ),
    ),
    MediaModel(
      objectId: '1',
      createdAt: '1',
      media: {
        'url':
            'https://i.pinimg.com/originals/4f/ea/17/4fea174592f4794c983ea0d1bf122428.jpg',
      },
      user: UserModel(
        objectId: '1',
        createdAt: '1',
        username: 'Johanna',
        proPic: {
          'url':
              'https://i.pinimg.com/736x/a3/f6/91/a3f691a2c699fb79da00aace939b267b.jpg',
        },
        bio: 'Slut',
      ),
    ),
    MediaModel(
      objectId: '1',
      createdAt: '1',
      media: {
        'url':
            'https://i.pinimg.com/originals/4f/ea/17/4fea174592f4794c983ea0d1bf122428.jpg',
      },
      user: UserModel(
        objectId: '1',
        createdAt: '1',
        username: 'Johanna',
        proPic: {
          'url':
              'https://i.pinimg.com/736x/a3/f6/91/a3f691a2c699fb79da00aace939b267b.jpg',
        },
        bio: 'Slut',
      ),
    ),
  ],
);

final Map<String, PostModel> mockPosts = {
  '1': const PostModel(
    objectId: '1',
    createdAt: '1',
    caption: 'Shoe Selfie',
    medias: [
      MediaModel(
        objectId: '1',
        createdAt: '1',
        media: {
          'url':
              'https://i.pinimg.com/originals/4f/ea/17/4fea174592f4794c983ea0d1bf122428.jpg',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'Johanna',
          proPic: {
            'url':
                'https://i.pinimg.com/736x/a3/f6/91/a3f691a2c699fb79da00aace939b267b.jpg',
          },
          bio: 'Slut',
        ),
      ),
      MediaModel(
        objectId: '2',
        createdAt: '1',
        media: {
          'url':
              'https://preview.redd.it/he365kdqvhj51.jpg?auto=webp&s=45b712a86de64b1fab1f42f367f344c94e42d050',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPic: {
            'url':
                'https://i.pinimg.com/736x/e0/21/8f/e0218f2b6a1d7c71f080749045233c63.jpg',
          },
          bio: 'Slut',
        ),
      ),
      MediaModel(
        objectId: '3',
        createdAt: '1',
        media: {
          'url':
              'https://s3.r29static.com/bin/entry/146/0,1463,3024,2268/x,80/1829672/image.jpg',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'Jessica',
          proPic: {
            'url':
                'https://data.whicdn.com/images/298487925/original.jpg?t=1534274746',
          },
          bio: 'Slut',
        ),
      ),
      MediaModel(
        objectId: '4',
        createdAt: '1',
        media: {
          'url':
              'https://st2.depositphotos.com/3978719/11406/i/600/depositphotos_114063400-stock-photo-close-up-of-legs-woman.jpg',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'Jessie',
          proPic: {
            'url':
                'https://i.pinimg.com/736x/78/4f/e8/784fe85e83e44328112af4298efdd9d6.jpg',
          },
          bio: 'Slut',
        ),
      ),
    ],
  ),
  '2': const PostModel(
    objectId: '2',
    createdAt: '1',
    caption: 'Next Meal',
    medias: [
      MediaModel(
        objectId: '5',
        createdAt: '1',
        media: {
          'url':
              'https://media-cdn.tripadvisor.com/media/photo-s/10/13/93/96/grigliata-mista.jpg',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPic: {
            'url':
                'https://i.kym-cdn.com/photos/images/facebook/002/115/721/611.jpg',
          },
          bio: 'Slut',
        ),
      ),
      MediaModel(
        objectId: '6',
        createdAt: '1',
        media: {
          'url':
              'https://i.pinimg.com/736x/70/31/60/703160fa956b3d48a7c84d57e0a34088.jpg',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPic: {
            'url':
                'https://play-lh.googleusercontent.com/bTjUXfgtmtC0G1xuKUAAlKoGQQAjlRc9it2rrOFakxLlNTdx16nbpMcR9VHNSSmoOw',
          },
          bio: 'Slut',
        ),
      ),
      MediaModel(
        objectId: '7',
        createdAt: '1',
        media: {
          'url':
              'https://i.pinimg.com/originals/92/d8/95/92d8956ba1256c436da36b6023ca8560.jpg',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPic: {
            'url':
                'https://e1.pxfuel.com/desktop-wallpaper/534/172/desktop-wallpaper-stylish-people-to-follow-on-instagram-instagram-girl-profile-pic-thumbnail.jpg',
          },
          bio: 'Slut',
        ),
      ),
      MediaModel(
        objectId: '8',
        createdAt: '1',
        media: {
          'url':
              'https://i.pinimg.com/736x/13/66/7b/13667b785a9a649fab3100d27f9b2e35.jpg',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPic: {
            'url':
                'https://techtrickseo.com/wp-content/uploads/2019/11/simmi.jpg',
          },
          bio: 'Slut',
        ),
      ),
    ],
  ),
  '3': const PostModel(
    objectId: '3',
    createdAt: '1',
    caption: 'Favorite Dress',
    medias: [
      MediaModel(
        objectId: '9',
        createdAt: '1',
        media: {
          'url':
              'https://flyingcdn-e81424e1.b-cdn.net/wp-content/uploads/2022/06/sabo.jpeg',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPic: {
            'url':
                'https://i.pinimg.com/736x/2e/9a/bf/2e9abffabb021dede5067950ca490ea4.jpg',
          },
          bio: 'Slut',
        ),
      ),
      MediaModel(
        objectId: '10',
        createdAt: '1',
        media: {
          'url':
              'https://i0.wp.com/greenweddingshoes.com/wp-content/uploads/2022/05/boho-print-casual-summer-dresses.jpeg?fit=1024%2C9999',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPic: {
            'url':
                'https://t3.ftcdn.net/jpg/02/96/66/58/360_F_296665879_g3GUJU6Vv9KzKkcNyaQ4uXEcCzRT6hSc.jpg',
          },
          bio: 'Slut',
        ),
      ),
      MediaModel(
        objectId: '11',
        createdAt: '1',
        media: {
          'url':
              'https://i.pinimg.com/originals/63/4d/e4/634de43cee496c03d69ce1b6486b7b23.jpg',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPic: {
            'url':
                'https://i.pinimg.com/736x/c8/83/0e/c8830e77b48ab4c55f478f1349ddc18c.jpg',
          },
          bio: 'Slut',
        ),
      ),
      MediaModel(
        objectId: '12',
        createdAt: '1',
        media: {
          'url':
              'https://i.etsystatic.com/32949567/r/il/bd85de/3958833269/il_fullxfull.3958833269_mmlu.jpg',
        },
        user: UserModel(
          objectId: '1',
          createdAt: '1',
          username: 'James',
          proPic: {
            'url':
                'https://i.pinimg.com/736x/5f/46/68/5f4668a11cf7a39a50900b3b47d2d392.jpg',
          },
          bio: 'Slut',
        ),
      ),
    ],
  ),
};

final Map<String, UserModel> mockFriends = {
  'Johanna': const UserModel(
    objectId: 'Johanna',
    createdAt: '1',
    username: 'Johanna',
    proPic: {
      'url':
          'https://i.pinimg.com/736x/a3/f6/91/a3f691a2c699fb79da00aace939b267b.jpg',
    },
    bio: 'Slut',
  ),
  '2': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'James',
    proPic: {
      'url':
          'https://i.pinimg.com/736x/e0/21/8f/e0218f2b6a1d7c71f080749045233c63.jpg',
    },
    bio: 'Slut',
  ),
  '3': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Jennifer',
    proPic: {
      'url':
          'https://data.whicdn.com/images/298487925/original.jpg?t=1534274746',
    },
    bio: 'Slut',
  ),
  '4': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Samantha',
    proPic: {
      'url':
          'https://qph.cf2.quoracdn.net/main-qimg-11d0c7a027d67e01bfd550dc0f0237da-lq',
    },
    bio: 'Slut',
  ),
  '5': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Jacob',
    proPic: {
      'url': 'https://i.kym-cdn.com/photos/images/facebook/002/115/721/611.jpg',
    },
    bio: 'Slut',
  ),
  '6': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Hailey',
    proPic: {
      'url':
          'https://play-lh.googleusercontent.com/bTjUXfgtmtC0G1xuKUAAlKoGQQAjlRc9it2rrOFakxLlNTdx16nbpMcR9VHNSSmoOw',
    },
    bio: 'Slut',
  ),
  '7': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Rihanna',
    proPic: {
      'url':
          'https://e1.pxfuel.com/desktop-wallpaper/534/172/desktop-wallpaper-stylish-people-to-follow-on-instagram-instagram-girl-profile-pic-thumbnail.jpg',
    },
    bio: 'Slut',
  ),
  '8': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Janina',
    proPic: {
      'url':
          'https://i.pinimg.com/736x/2e/9a/bf/2e9abffabb021dede5067950ca490ea4.jpg',
    },
    bio: 'Slut',
  ),
  '9': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Kiwoo',
    proPic: {
      'url':
          'https://i.pinimg.com/736x/5f/46/68/5f4668a11cf7a39a50900b3b47d2d392.jpg',
    },
    bio: 'Slut',
  ),
};

final Map<String, UserModel> mockSuggestions = {
  '1': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Heather',
    proPic: {
      'url':
          'https://t3.ftcdn.net/jpg/02/96/66/58/360_F_296665879_g3GUJU6Vv9KzKkcNyaQ4uXEcCzRT6hSc.jpg',
    },
    bio: 'Slut',
  ),
  '2': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Bernice',
    proPic: {
      'url':
          'https://i.pinimg.com/736x/c8/83/0e/c8830e77b48ab4c55f478f1349ddc18c.jpg',
    },
    bio: 'Slut',
  ),
};

final Map<String, UserModel> mockRequests = {
  '1': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Sally',
    proPic: {
      'url':
          'https://www.stylevore.com/wp-content/uploads/2019/06/Sonya-Rudskaya-La-imagen-puede-contener-1-persona-primer-plano.jpg',
    },
    bio: 'Slut',
  ),
};

final Map<String, UserModel> mockSentRequests = {
  '1': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Natalia',
    proPic: {
      'url':
          'https://i.pinimg.com/736x/34/54/b2/3454b2cfbdf4e33e903c2f3bb757476b.jpg',
    },
    bio: 'Slut',
  ),
  '2': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Siri',
    proPic: {
      'url':
          'https://i.pinimg.com/originals/3a/83/25/3a83253a53c720ee1747181eb41281de.jpg',
    },
    bio: 'Slut',
  ),
};

final Map<String, UserModel> mockSearch = {
  '1': const UserModel(
    objectId: '1',
    createdAt: '1',
    username: 'Johanna',
    proPic: {
      'url':
          'https://i.pinimg.com/736x/a3/f6/91/a3f691a2c699fb79da00aace939b267b.jpg',
    },
    bio: 'Slut',
  ),
  '2': const UserModel(
    objectId: '2',
    createdAt: '1',
    username: 'James',
    proPic: {
      'url':
          'https://i.pinimg.com/736x/e0/21/8f/e0218f2b6a1d7c71f080749045233c63.jpg',
    },
    bio: 'Slut',
  ),
  '3': const UserModel(
    objectId: '3',
    createdAt: '1',
    username: 'Jennifer',
    proPic: {
      'url':
          'https://data.whicdn.com/images/298487925/original.jpg?t=1534274746',
    },
    bio: 'Slut',
  ),
  '4': const UserModel(
    objectId: '4',
    createdAt: '1',
    username: 'Samantha',
    proPic: {
      'url':
          'https://qph.cf2.quoracdn.net/main-qimg-11d0c7a027d67e01bfd550dc0f0237da-lq',
    },
    bio: 'Slut',
  ),
  '5': const UserModel(
    objectId: '5',
    createdAt: '1',
    username: 'Jacob',
    proPic: {
      'url': 'https://i.kym-cdn.com/photos/images/facebook/002/115/721/611.jpg',
    },
    bio: 'Slut',
  ),
  '6': const UserModel(
    objectId: '6',
    createdAt: '1',
    username: 'Hailey',
    proPic: {
      'url':
          'https://play-lh.googleusercontent.com/bTjUXfgtmtC0G1xuKUAAlKoGQQAjlRc9it2rrOFakxLlNTdx16nbpMcR9VHNSSmoOw',
    },
    bio: 'Slut',
  ),
  '7': const UserModel(
    objectId: '7',
    createdAt: '1',
    username: 'Rihanna',
    proPic: {
      'url':
          'https://e1.pxfuel.com/desktop-wallpaper/534/172/desktop-wallpaper-stylish-people-to-follow-on-instagram-instagram-girl-profile-pic-thumbnail.jpg',
    },
    bio: 'Slut',
  ),
  '8': const UserModel(
    objectId: '8',
    createdAt: '1',
    username: 'Janina',
    proPic: {
      'url':
          'https://i.pinimg.com/736x/2e/9a/bf/2e9abffabb021dede5067950ca490ea4.jpg',
    },
    bio: 'Slut',
  ),
  '9': const UserModel(
    objectId: '9',
    createdAt: '1',
    username: 'Kiwoo',
    proPic: {
      'url':
          'https://i.pinimg.com/736x/5f/46/68/5f4668a11cf7a39a50900b3b47d2d392.jpg',
    },
    bio: 'Slut',
  ),
};