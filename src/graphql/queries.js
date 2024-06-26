/* eslint-disable */
// this is an auto generated file. This will be overwritten

export const getComment = /* GraphQL */ `
  query GetComment($id: ID!) {
    getComment(id: $id) {
      id
      ownerId
      owner
      ownerFullname
      targetId
      targetType
      content
      numberOfLikes
      userIdLikes
      createdAt
      parentId
      updatedAt
      parent {
        id
        ownerId
        owner
        ownerFullname
        targetId
        targetType
        content
        numberOfLikes
        userIdLikes
        createdAt
        parentId
        updatedAt
        parent {
          id
          ownerId
          owner
          ownerFullname
          targetId
          targetType
          content
          numberOfLikes
          userIdLikes
          createdAt
          parentId
          updatedAt
        }
        childrens {
          nextToken
        }
      }
      childrens {
        items {
          id
          ownerId
          owner
          ownerFullname
          targetId
          targetType
          content
          numberOfLikes
          userIdLikes
          createdAt
          parentId
          updatedAt
        }
        nextToken
      }
    }
  }
`;
export const listComments = /* GraphQL */ `
  query ListComments(
    $filter: ModelCommentFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listComments(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
        id
        ownerId
        owner
        ownerFullname
        targetId
        targetType
        content
        numberOfLikes
        userIdLikes
        createdAt
        parentId
        updatedAt
        parent {
          id
          ownerId
          owner
          ownerFullname
          targetId
          targetType
          content
          numberOfLikes
          userIdLikes
          createdAt
          parentId
          updatedAt
        }
        childrens {
          nextToken
        }
      }
      nextToken
    }
  }
`;
export const getChat = /* GraphQL */ `
  query GetChat($id: ID!) {
    getChat(id: $id) {
      id
      ownerId
      owner
      ownerFullname
      content
      participantUserIds
      imageUrls
      createdAt
      parentId
      updatedAt
      parent {
        id
        ownerId
        owner
        ownerFullname
        content
        participantUserIds
        imageUrls
        createdAt
        parentId
        updatedAt
        parent {
          id
          ownerId
          owner
          ownerFullname
          content
          participantUserIds
          imageUrls
          createdAt
          parentId
          updatedAt
        }
        childrens {
          nextToken
        }
      }
      childrens {
        items {
          id
          ownerId
          owner
          ownerFullname
          content
          participantUserIds
          imageUrls
          createdAt
          parentId
          updatedAt
        }
        nextToken
      }
    }
  }
`;
export const listChats = /* GraphQL */ `
  query ListChats(
    $filter: ModelChatFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listChats(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
        id
        ownerId
        owner
        ownerFullname
        content
        participantUserIds
        imageUrls
        createdAt
        parentId
        updatedAt
        parent {
          id
          ownerId
          owner
          ownerFullname
          content
          participantUserIds
          imageUrls
          createdAt
          parentId
          updatedAt
        }
        childrens {
          nextToken
        }
      }
      nextToken
    }
  }
`;
