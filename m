Received: from eggs.gnu.org ([209.51.188.92]:44059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1glbNN-0006m0-3v
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1glbNL-00038b-Ml
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:20:36 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:36351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1glbNL-00037u-I2
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:20:35 -0500
Received: by mail-io1-f51.google.com with SMTP id m19so16663262ioh.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 07:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
	<20190118144724.66914-1-emaste@freebsd.org> <87a7ju1de5.fsf@linaro.org>
In-Reply-To: <87a7ju1de5.fsf@linaro.org>
From: Ed Maste <emaste@freebsd.org>
Date: Mon, 21 Jan 2019 10:20:20 -0500
Message-ID: <CAPyFy2CTXcq2ue7BVAHWeOtCh4+ovtKHvgMDoVhetNKdKRTSsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Mon, 21 Jan 2019 at 06:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> I should be able to add CirrusCI to the QEMU project github when we
> merge. I see there is another revision coming in so I''ll wait for that
> before I queue it up.

Do you mean my eadd119 commit "cirrus: tail dmesg to see if this is
due to OOM"? I didn't intend to submit that (at least not in exactly
the current form); I added it while looking at what I believe was a
transient Cirrus failure.
