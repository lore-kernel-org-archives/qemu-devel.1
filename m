Received: from eggs.gnu.org ([2001:4830:134:3::10]:41738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gWLrH-00033m-QZ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gWLrG-0002Ow-3q
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:44:27 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gWLrF-0002Nk-SW
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:44:26 -0500
Received: by mail-oi1-x244.google.com with SMTP id j21so8959163oii.8
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 05:44:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1812091654210.8180@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1812091654210.8180@zero.eik.bme.hu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 10 Dec 2018 14:44:23 +0100
Message-ID: <CAL1e-=ihjy_mvxUPtcKBxUOPrBquAe+=A3K6sXz4c=r2Roe=KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qdev documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Dec 9, 2018 5:00 PM, "BALATON Zoltan" <balaton@eik.bme.hu> wrote:
>
> Hello,
>
> I was searching for some good summary on how to implement new devices and
machines in QEMU for those who might want to start working on it but not
much seems to be available. I've found this which seems to be useful:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2011-07/msg00842.html
>
> What happened to this? Was it ever finished? It does not seem to be in
docs, only qdev-device-use.txt is there. (Maybe this qdev-for-programmers
doc could be in docs/devel.)
>
> Thank you,
> BALATON Zoltan
>

Hi, Zoltan.

I unfortunatelly can't answer your questions, but I do agree that some
writings on QEMU internals would be super-helpful. The problem is that, as
we all know, documentation often gets forgotten in our hectic pace of
development, even if it is planned to be written.

It could be that a problem is there is no a single person (at least I don't
know him/her) who would actively take care of the internal docs as a whole,
and, let's say, constantly ping other developers to improve or update their
bits and pieces.

Good that you brought this to our attention!

Aleksandar
