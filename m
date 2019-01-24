Received: from eggs.gnu.org ([209.51.188.92]:58208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfFi-0005Ni-K0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmf3K-0004ql-Gl
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:28:19 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:45904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmf3K-0004qR-Bf
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:28:18 -0500
Received: by mail-ot1-x331.google.com with SMTP id 32so5159944ota.12
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20190123114220.16972-1-alex.bennee@linaro.org>
In-Reply-To: <20190123114220.16972-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 13:28:06 +0000
Message-ID: <CAFEAcA-8MDXBnDDMzz5gk1-=ErSM4BWNtTkHt2XcGz4NBdsBpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/11] check-softfloat,
 fp-bench and clang compile fixes
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

On Wed, 23 Jan 2019 at 11:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 952bc8b3c2cbba78261923a1e8ca55cda261de=
e9:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-01-21' i=
nto staging (2019-01-22 17:56:21 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-fpu-next-230119-2
>
> for you to fetch changes up to 7617010250822677348af2bd98f048be10e7f334:
>
>   tests/Makefile: add check-softfloat rule (2019-01-23 08:30:01 +0000)
>
> ----------------------------------------------------------------
> Some more softfloat/fpu fixes
>
>    - make check-softfloat
>    - fixes for fp-bench
>    - workaround broken host fma
>    - compile fix for s390x/clang
>    - fixed for bigendian (v2)
>    - minor makefile tweaks (v2)
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
