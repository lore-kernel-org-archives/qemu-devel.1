Received: from eggs.gnu.org ([2001:4830:134:3::10]:40554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fPSqW-0008Tr-TE
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 09:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fPSqV-0002yC-Vx
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 09:14:56 -0400
Received: from mail-yw0-x22b.google.com ([2607:f8b0:4002:c05::22b]:38594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1fPSqV-0002y0-QN
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 09:14:55 -0400
Received: by mail-yw0-x22b.google.com with SMTP id w13-v6so3342148ywa.5
	for <qemu-devel@nongnu.org>; Sun, 03 Jun 2018 06:14:55 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAJSP0QWELqGP56Dm5qyS7zGe_xdPwB5t6CZXkqhdmX16RKM9nw@mail.gmail.com>
References: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
	<CAJSP0QWELqGP56Dm5qyS7zGe_xdPwB5t6CZXkqhdmX16RKM9nw@mail.gmail.com>
MIME-Version: 1.0
Date: Sun, 3 Jun 2018 06:14:54 -0700
Message-ID: <CAG7hfcJxiPYou5dNaWcL8p9uQxHUX1Qa7PDaku_z80Qx-S=yGg@mail.gmail.com>
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
To: Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>

On 2 June 2018 at 17:15:15, Stefan Hajnoczi (stefanha@gmail.com) wrote:

> > I have put together a basic Cortex M0 ARMv6-M CPU that can serve
> as
> the basis for this work. Please see the RFC patches that I've sent
> separately.

you can also take a look at the Cortex-M implementation in the GNU MCU
Eclipse QEMU.

https://gnu-mcu-eclipse.github.io/qemu/

it is a bit old now; a refresh is planned, but no date is set yet.


regards,

Liviu
