Received: from eggs.gnu.org ([2001:4830:134:3::10]:34874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPnNN-00058G-4a
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPnNJ-0005FF-5I
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:10:13 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fPnNI-0005Es-Qx
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:10:09 -0400
Received: by mail-wr0-x234.google.com with SMTP id f16-v6so27472251wrm.3
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 04:10:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG7hfcJxiPYou5dNaWcL8p9uQxHUX1Qa7PDaku_z80Qx-S=yGg@mail.gmail.com>
References: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
	<CAJSP0QWELqGP56Dm5qyS7zGe_xdPwB5t6CZXkqhdmX16RKM9nw@mail.gmail.com>
	<CAG7hfcJxiPYou5dNaWcL8p9uQxHUX1Qa7PDaku_z80Qx-S=yGg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 4 Jun 2018 12:10:07 +0100
Message-ID: <CAJSP0QW4dDpifDJgyuLKo3Ar53OGwUMP16e++HnDe69NA3-Mmw@mail.gmail.com>
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
To: Liviu Ionescu <ilg@livius.net>
Cc: Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>

On Sun, Jun 3, 2018 at 2:14 PM, Liviu Ionescu <ilg@livius.net> wrote:
> On 2 June 2018 at 17:15:15, Stefan Hajnoczi (stefanha@gmail.com) wrote:
>
>> > I have put together a basic Cortex M0 ARMv6-M CPU that can serve
>> as
>> the basis for this work. Please see the RFC patches that I've sent
>> separately.
>
> you can also take a look at the Cortex-M implementation in the GNU MCU
> Eclipse QEMU.
>
> https://gnu-mcu-eclipse.github.io/qemu/
>
> it is a bit old now; a refresh is planned, but no date is set yet.

Thanks for mentioning it.

What is the status of the Cortex M0 in that source tree?  Is it complete?

Thanks,
Stefan
