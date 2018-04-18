Received: from eggs.gnu.org ([2001:4830:134:3::10]:33031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f8jzC-00043T-HP
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f8jz7-0005uE-VG
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:06:46 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:45674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f8jz7-0005sN-MZ
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:06:41 -0400
Received: by mail-wr0-x232.google.com with SMTP id u11-v6so3167865wri.12
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 03:06:41 -0700 (PDT)
References: <CAMxP3BSFEuknshd05kSn8EjNuv8F8aPGuNFG3qUd0Ap6GbZFrQ@mail.gmail.com>
	<18e4de85-274e-54aa-e34e-4fd3f82e40e2@weilnetz.de>
	<CAMxP3BThUkaPWRq=D2AhecGgpmC-F=_fGbBQX-oyaqMs95s3Pw@mail.gmail.com>
	<CAMxP3BRXh8MLz2KQ_bG-v0KzrL9CxG7bCbtsEfijJ2DUFAbjUA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAMxP3BRXh8MLz2KQ_bG-v0KzrL9CxG7bCbtsEfijJ2DUFAbjUA@mail.gmail.com>
Date: Wed, 18 Apr 2018 11:06:39 +0100
Message-ID: <87y3hkakwg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Latest v2.12.0-rc4 has compiling error, rc3 is OK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org


Bob Chen <a175818323@gmail.com> writes:

> I found that it has nothing to do with the release version, but the github
> one is just not able to work...
>
> So what github and qemu.org provide are totally different things?

AFAICT github generates those tarballs automatically whenever it sees a
tag. But it's not the same as the official release tarballs.

--
Alex Benn=C3=A9e
