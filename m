Received: from eggs.gnu.org ([2001:4830:134:3::10]:35538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fPnS4-0006Tx-CV
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fPnS3-0007EA-IV
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:15:04 -0400
Received: from mail-yw0-x232.google.com ([2607:f8b0:4002:c05::232]:46988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1fPnS3-0007Dy-DM
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:15:03 -0400
Received: by mail-yw0-x232.google.com with SMTP id v197-v6so9031003ywc.13
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 04:15:03 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAJSP0QW4dDpifDJgyuLKo3Ar53OGwUMP16e++HnDe69NA3-Mmw@mail.gmail.com>
References: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
	<CAJSP0QWELqGP56Dm5qyS7zGe_xdPwB5t6CZXkqhdmX16RKM9nw@mail.gmail.com>
	<CAG7hfcJxiPYou5dNaWcL8p9uQxHUX1Qa7PDaku_z80Qx-S=yGg@mail.gmail.com>
	<CAJSP0QW4dDpifDJgyuLKo3Ar53OGwUMP16e++HnDe69NA3-Mmw@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 4 Jun 2018 07:15:01 -0400
Message-ID: <CAG7hfcLvhTgz2497-wDD0e02U7hX4eeRPuzqwaL+ugxemPSkzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Cortex M0 emulation tasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>

On 4 June 2018 at 14:10:08, Stefan Hajnoczi (stefanha@gmail.com) wrote:

> What is the status of the Cortex M0 in that source tree? Is it complete?

all supported Cortex-M devices run blinky demos using the official
CMSIS initialisations, but I would not qualify them as complete.

they also include graphics support, the leds and buttons are active in
the board picture. highly appreciated by users.


regards,

Liviu
