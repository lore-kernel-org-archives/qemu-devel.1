Received: from eggs.gnu.org ([2001:4830:134:3::10]:45791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnS1f-0000a7-Dv
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnS1a-0004CC-GB
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:09:03 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:37981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnS1a-0004BH-7i
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:08:58 -0400
Received: by mail-wr0-x231.google.com with SMTP id 40so106460wrv.5
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 09:08:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831103432.6007-1-marcandre.lureau@redhat.com>
References: <20170831103432.6007-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 17:08:36 +0100
Message-ID: <CAFEAcA99Ne6JMZrLctVpXMQD0iQDfCg9JGypvw4xW6-j_L5DLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/29] Code cleanup patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 31 August 2017 at 11:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit 1201d308519f1e915866d7583d5136d03cc1d3=
84:
>
>   slirp: fix clearing ifq_so from pending packets (2017-08-30 23:14:34 +0=
100)
>
> are available in the git repository at:
>
>   https://github.com/elmarco/qemu.git tags/tidy-pull-request
>
> for you to fetch changes up to e4d67e4f2e06128bc7f07263afe9acc2e2242fdc:
>
>   eepro100: replace g_malloc()+memcpy() with g_memdup() (2017-08-31 12:29=
:07 +0200)
>
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
