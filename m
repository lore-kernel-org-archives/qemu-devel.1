Received: from eggs.gnu.org ([2001:4830:134:3::10]:48570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eu0JA-00063y-Jn
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eu0J9-0004LB-FQ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:30:28 -0500
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:35685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eu0J9-0004Kv-8H
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:30:27 -0500
Received: by mail-ot0-x22e.google.com with SMTP id r30so6346251otr.2
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 10:30:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180308150329.27238-1-alex.bennee@linaro.org>
References: <20180308150329.27238-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 18:30:06 +0000
Message-ID: <CAFEAcA8fEzmcnL0bkjfw6UJF9MaJLOUebGmGXR_LLXC=F7VPeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] disable broken shippable build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 March 2018 at 15:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 0ab4537f08e09b13788db67efd760592fb7db7=
69:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2018-0=
3-07-1' into staging (2018-03-08 12:56:39 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-shippable-disable-ppc-080=
318-1
>
> for you to fetch changes up to b2dba411cf5afc6771e0dd9900fa2b5031a686ac:
>
>   .shippable.yml: disable powerpc-cross image (2018-03-08 14:34:41 +0000)
>
> ----------------------------------------------------------------
> One fix to disable broken ppc cross-compile test on shippable
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (1):
>       .shippable.yml: disable powerpc-cross image
>
>  .shippable.yml | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

-- PMM
