export interface iFriends {
    receiveFriends: Array<iReceiveFriends>
    friends: Array<iFriendList>
}

interface iReceiveFriends extends iFriendList { };

interface iFriendList {
    friendUserNum: number;
    friendNickname: string;
    emblem: number;
    leftoverMessage: string;
    friendUserCode: string
}