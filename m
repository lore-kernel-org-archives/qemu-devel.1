Received: from eggs.gnu.org ([2001:4830:134:3::10]:47955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewUYw-000360-F4
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewUYv-0007oQ-FL
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:13:02 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:38865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewUYv-0007nz-A4
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:13:01 -0400
Received: by mail-ot0-x22b.google.com with SMTP id 95-v6so7202468ote.5
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 08:13:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313164625.4646-1-alex.bennee@linaro.org>
References: <20180313164625.4646-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 15:12:40 +0000
Message-ID: <CAFEAcA-h2jopPozaya0HQf4K5Cv7yOq2cfXmz4hFOftibscMGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Reduce Travis timeouts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 13 March 2018 at 16:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 22ef7ba8e8ce7fef297549b3defcac333742b8=
04:
>
>   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' i=
nto staging (2018-03-13 11:42:45 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-travis-speedup-130318-1
>
> for you to fetch changes up to 0b438fa627ca192e4be2c527bf188706d64bdd0d:
>
>   .travis.yml: add --disable-user with the rest of the disables (2018-03-=
13 16:22:23 +0000)
>
> ----------------------------------------------------------------
> Some updates to reduce timeouts in Travis
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (3):
>       .travis.yml: drop setting default log output
>       .travis.yml: split default config into system and user
>       .travis.yml: add --disable-user with the rest of the disables
>
>  .travis.yml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
