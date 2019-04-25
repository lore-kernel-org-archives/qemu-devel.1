Received: from eggs.gnu.org ([209.51.188.92]:37636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJega-00067h-Gp
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJegZ-0002nI-JS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:45:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJegZ-0002m3-C3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:45:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so7826692wrs.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:45:11 -0700 (PDT)
References: <20190408182748.1238-1-jan.bobek@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190408182748.1238-1-jan.bobek@gmail.com>
Date: Thu, 25 Apr 2019 14:45:08 +0100
Message-ID: <87y33yurkr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 0/5] Fix RISU build for i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Bobek <jan.bobek@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>


Jan Bobek <jan.bobek@gmail.com> writes:

> Hi all,
>
<snip>
> Thanks,
> -Jan Bobek
>
> P.S. This is my first time using git send-email, so please bear with
>      me if something goes wrong and/or let me know how I can improve
>      my future submissions. Thank you!

Looks good to me. Excellent first patch series ;-)

I assume you'll post a v2 once you've integrated Richard's fixups to the
appropriate patches.

Have you had a chance to look at getting a .risu and risugen working yet?

--
Alex Benn=C3=A9e
