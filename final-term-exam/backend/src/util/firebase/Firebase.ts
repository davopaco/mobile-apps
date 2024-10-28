import * as admin from "firebase-admin";
import path from "path";
import DeviceMessage from "../../instamess/model/deviceMessage/DeviceMessage";

export default class Firebase {
  private static instance: Firebase;
  private static firebaseApp: admin.app.App;

  private constructor() {
    Firebase.firebaseApp = admin.initializeApp({
      credential: admin.credential.cert(
        path.join(__dirname, "account", "sAccountKey.json")
      ),
    });
  }

  public static getInstance(): Firebase {
    if (!Firebase.instance) {
      Firebase.instance = new Firebase();
    }
    return Firebase.instance;
  }

  public getFirebaseApp(): admin.app.App {
    return Firebase.firebaseApp;
  }

  public convertDeviceMessageToFirebaseMessage(
    deviceMessage: DeviceMessage
  ): admin.messaging.Message {
    return {
      notification: {
        title: deviceMessage.getMessage().getTitle(),
        body: deviceMessage.getMessage().getContent(),
      },
      token: deviceMessage.getDevice().getFcmToken(),
    };
  }
}
