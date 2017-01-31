Received: from eggs.gnu.org ([2001:4830:134:3::10]:50044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYedx-0004f2-2L
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYedw-0008Vx-E0
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:03:09 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:33325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYedw-0008Vm-9Z
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:03:08 -0500
Received: by mail-vk0-x22f.google.com with SMTP id k127so244565847vke.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 12:03:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKmAKmiiM5LvLGaT51kJUp4=jKU_=QAqo7JOtxDuso9CQ@mail.gmail.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
	<CAFEAcA9jzxGZXXoFWxrDztb4or=0LaqpeNa3YH9rpZePa2mFdA@mail.gmail.com>
	<CAJ+F1CJzchr6f9nfCsHyOUFmz-08e4R-8BLi4QWc3q0h0+9Quw@mail.gmail.com>
	<3fdd19c5-2017-7c5d-22ad-a44bd15414d6@redhat.com>
	<CAJ+F1CKmAKmiiM5LvLGaT51kJUp4=jKU_=QAqo7JOtxDuso9CQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 20:02:47 +0000
Message-ID: <CAFEAcA9wzm051ZsfAXb8KNE6hQV1r-B8Us7gcAsDJdiRLWkxxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/41] Chr split patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 31 January 2017 at 19:37, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Thanks, patch updated, tag updated.
>
> Peter, let me know if you want me to resend the pull request.

I'll put it back on my list. NB that the guaranteed reliable way
for me to spot that you want me to reprocess a respin is to
send a new cover letter email (you need not resend all the
individual patch mails if they're basically the same). That
will cause my filters to spot the cover letter email and
put it back in the folder of things to process. Doing anything
else is relying on my happening to read your email informally
asking for a re-run, which in this case I did but if you're
unlucky I might miss it.

TLDR: resending the cover letter entrusts your fate to the hands
of an infallible unsleeping robot; informal requests leave you
reliant on a careless human. The robot is your friend.

thanks
-- PMM
