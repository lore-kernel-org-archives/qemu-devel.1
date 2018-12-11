Received: from eggs.gnu.org ([2001:4830:134:3::10]:56676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gWVre-0004Gc-4N
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 19:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gWVrd-0001zT-Fk
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 19:25:30 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gWVrd-0001yC-B1
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 19:25:29 -0500
Received: by mail-yw1-xc43.google.com with SMTP id y194so4745322ywg.3
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 16:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-8-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-8-alex.bennee@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 10 Dec 2018 16:25:16 -0800
Message-ID: <CAMo8BfJHo=6VJXbrnAYn+PiQECA6-Hj_rCOVPc12rPiKfc3u=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 07/13] tests/tcg/xtensa: enable system
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, amarkovic@wavecomp.com, Stafford Horne <shorne@gmail.com>

On Mon, Dec 10, 2018 at 7:28 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/xtensa/Makefile                | 93 ------------------------
>  tests/tcg/xtensa/Makefile.softmmu-target | 43 +++++++++++
>  2 files changed, 43 insertions(+), 93 deletions(-)
>  delete mode 100644 tests/tcg/xtensa/Makefile

That Makefile provides a few nice goals for guest and host debugging
and a way to run tests on Tensilica ISS, it would be nice to keep it.

--=20
Thanks.
-- Max
