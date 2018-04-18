Received: from eggs.gnu.org ([2001:4830:134:3::10]:55494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1f8jnJ-00008U-Rb
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1f8jnI-0007Xv-Q7
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:54:29 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:33482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1f8jnI-0007XZ-K1
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:54:28 -0400
Received: by mail-io0-x231.google.com with SMTP id s14-v6so1711347ioc.0
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 02:54:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-sGiZFdAa8Gnfbo_=o-ZZbChyDJAV9oGmMTBC8BNS3sQ@mail.gmail.com>
References: <CAMxP3BSFEuknshd05kSn8EjNuv8F8aPGuNFG3qUd0Ap6GbZFrQ@mail.gmail.com>
	<18e4de85-274e-54aa-e34e-4fd3f82e40e2@weilnetz.de>
	<CAMxP3BThUkaPWRq=D2AhecGgpmC-F=_fGbBQX-oyaqMs95s3Pw@mail.gmail.com>
	<CAMxP3BRXh8MLz2KQ_bG-v0KzrL9CxG7bCbtsEfijJ2DUFAbjUA@mail.gmail.com>
	<CAFEAcA-sGiZFdAa8Gnfbo_=o-ZZbChyDJAV9oGmMTBC8BNS3sQ@mail.gmail.com>
From: Bob Chen <a175818323@gmail.com>
Date: Wed, 18 Apr 2018 17:54:27 +0800
Message-ID: <CAMxP3BR8PLzKacyty+xLJyMf2wjFdQUgutQ+MJpnWH0_4PpfZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Latest v2.12.0-rc4 has compiling error, rc3 is OK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>

I think you can edit the github's repo description to tell people not to
download release from this site.

2018-04-18 17:29 GMT+08:00 Peter Maydell <peter.maydell@linaro.org>:

> On 18 April 2018 at 09:09, Bob Chen <a175818323@gmail.com> wrote:
> > I found that it has nothing to do with the release version, but the
> github
> > one is just not able to work...
> >
> > So what github and qemu.org provide are totally different things?
>
> The "tarballs" from github don't work and can't work, but
> github provides no mechanism for the project to say "don't
> create this page". You can complain to github about this
> if you like.
>
> You're best off starting with the project's own web
> page: https://www.qemu.org/ -- we use github only as
> a sort of backup git server in case our own is down.
>
> thanks
> -- PMM
>
