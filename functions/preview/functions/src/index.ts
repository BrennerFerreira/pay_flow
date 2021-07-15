/* eslint-disable object-curly-spacing */
/* eslint-disable require-jsdoc */
/* eslint-disable indent */
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const scheduledNotification = functions.pubsub
  .schedule("0 12 * * *")
  .timeZone("America/Sao_Paulo")
  .onRun(async () => {
    const usersDoc = await admin.firestore().collection("users").get();

    for (const doc of usersDoc.docs) {
      const todayBoletos = await getTodayBoletos(doc.id);

      if (!todayBoletos.length) {
        return;
      }

      const userTokens = await getUserDeviceTokens(doc.id);

      if (!userTokens.length) {
        return;
      }

      const isThereMoreThanOneBoleto = todayBoletos.length > 1;

      await sendPushFCM(
        userTokens,
        "Não se esqueça dos seus boletos!",
        `Há ${todayBoletos.length} ${
          isThereMoreThanOneBoleto ? "boletos que vencem" : "boleto que vence"
        } hoje! Copie ${
          isThereMoreThanOneBoleto ? "os códigos" : "o código"
        } de barras e marque-${isThereMoreThanOneBoleto ? "os" : "o"} como ${
          isThereMoreThanOneBoleto ? "pagos" : "pago"
        }!`
      );
    }
  });

interface Boleto {
  id: string;
  barCode: string;
  dueDate: number;
  name: string;
  paid: boolean;
  paidAt?: number;
  price: number;
}

async function getTodayBoletos(uid: string): Promise<Boleto[]> {
  const userDoc = await admin.firestore().collection("users").doc(uid).get();
  const boletosDoc: Boleto[] = userDoc.data()?.boletos ?? [];

  const today = new Date();

  const todayBoletos = boletosDoc.filter((boleto) => {
    const boletoDueDate = new Date(boleto.dueDate - 3 * 60 * 60 * 1000);
    const sameYear = boletoDueDate.getFullYear() === today.getFullYear();
    const sameMonth = boletoDueDate.getMonth() === today.getMonth();
    const sameDay = boletoDueDate.getDate() === today.getDate();

    return !boleto.paid && sameYear && sameMonth && sameDay;
  });

  return todayBoletos;
}

interface Token {
  token: string;
  updatedAt: string;
  platform: string;
}

async function getUserDeviceTokens(uid: string): Promise<string[]> {
  const userDoc = await admin.firestore().collection("users").doc(uid).get();

  const tokensDocs: Token[] = userDoc.data()?.tokens;

  if (!tokensDocs.length) {
    return [];
  }

  const tokens: string[] = tokensDocs.map((tk) => tk.token);

  return tokens;
}

async function sendPushFCM(tokens: string[], title: string, message: string) {
  if (tokens.length) {
    const payload = {
      notification: {
        title: title,
        body: message,
        click_action: "FLUTTER_NOTIFICATION_CLICK",
      },
    };
    return admin.messaging().sendToDevice(tokens, payload);
  }
  return;
}
