import Cache from "../Cache";

export default class ChatBuilder {

    private readonly nickName: string;
    private readonly userCode: string;
    private readonly text: string;

    public constructor(nickName: string, userCode: string, text: string) { 
        this.nickName = nickName;
        this.userCode = userCode;
        this.text = text
     }

    public toString() {
        return JSON.stringify({
            'topic': 'W_'.concat(this.userCode),
            'msg': this.message()
        })
    }

    private message(): string {
        return JSON.stringify({
            payload: this.payload()
        })
    }

    private payload(): any {
        return JSON.stringify({
            "senderUserCode": Cache.userCode,
            "chatType": 2,
            "chattingUIType": 0,
            "teamUserIds": null,
            "contents": JSON.stringify({
                "senderUserInfo": {
                    "userId": Cache.userNum,
                    "userCode": Cache.userCode,
                    "nickName": this.nickName,
                    "avatar": 100001,
                    "memo": null,
                    "emblemMark": 0,
                    "emblemBg": 0,
                    "emblemOutline": 0
                },
                "characterCode": 0,
                "contents": this.text,
                "parameters": null
            })
        })
    }
}