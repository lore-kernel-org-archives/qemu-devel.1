Received: from eggs.gnu.org ([2001:4830:134:3::10]:46983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYU8q-0003we-Hy
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYU8p-0002yX-IV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:22:36 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:37742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYU8p-0002yI-BJ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:22:35 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 33so23503021wrz.4
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:22:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87ziby6udk.fsf@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-4-alex.bennee@linaro.org>
	<d58f694c-cc8a-fb0f-f01c-ba1e2eebc6e1@twiddle.net>
	<1ff55ec6-b8e5-8696-7472-0ac22073ddf4@redhat.com>
	<87ziby6udk.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 10:22:13 +0100
Message-ID: <CAFEAcA_a9RW8zhaY6gpPuXAYk7twWgB0G39qOUTug44HbwyE7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 03/23] softfloat3c: dos2unix
 all files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 21 July 2017 at 09:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> One thing playing in my mind against moving to SoftFloat3c is the
> inscrutability of the upstream. It's nice there has been a new release
> with new features but there isn't a source repository or as far as I can
> tell a development list. It is basically as far as I can tell a one man
> project albeit backed by academic funding.

I think https://github.com/ucb-bar/berkeley-softfloat-3 may
be official-ish, though it's hard to tell with github repos.

thanks
-- PMM
