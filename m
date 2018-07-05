Received: from eggs.gnu.org ([2001:4830:134:3::10]:56008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb8id-0006ES-Kq
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb8ic-0001Yi-GZ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:11:03 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:41703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb8ic-0001Xf-Bf
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:11:02 -0400
Received: by mail-oi0-x22c.google.com with SMTP id k12-v6so18595861oiw.8
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:11:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 19:10:41 +0100
Message-ID: <CAFEAcA9aRyzJpairK_8Enp8nsdoPnxdJY0=+8CaS7TQkXOtFyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/20] Travis,
 Code Coverage and Cross Build updates
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

On 5 July 2018 at 17:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 6cf495be0b445789eeb7e88a6015c8cf74d4c1=
cf:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2018-07-05 13:33:52 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-code-coverage-and-build-t=
weaks-050718-3
>
> for you to fetch changes up to 19c9a18f45fc8d8b8e96a6b8ea6074d08b6a8612:
>
>   docker: add linux-user powered cross builder for QEMU (2018-07-05 16:57=
:39 +0100)
>
> ----------------------------------------------------------------
> Code coverage and other build tweaks
>
>   - revert 208ecb3e (and drop filter for mingw, tweak for check-tcg)
>   - some travis speed-ups
>   - modernise code coverage support
>   - docker image cleanups
>   - clean-up binfmt_misc docker infrastructure
>   - add debian-powerpc-user-cross image for ppc32 build
>
> ----------------------------------------------------------------


Applied, thanks.

-- PMM
