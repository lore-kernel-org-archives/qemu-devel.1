Received: from eggs.gnu.org ([2001:4830:134:3::10]:36515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNHJK-0000Rp-BP
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNHJI-0004Tk-Sd
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:03:54 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:42280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNHJI-0004T5-E3
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:03:52 -0500
Received: by mail-oi1-x236.google.com with SMTP id w13so4059827oiw.9
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 05:03:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181114131008.27599-1-alex.bennee@linaro.org>
References: <20181114131008.27599-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 13:03:31 +0000
Message-ID: <CAFEAcA-e6LqA_+OqjrMJ694n9_+qK0VOHKTn+9VrA1x1inhHvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for 3.1 0/2] Testing tweaks
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

On 14 November 2018 at 13:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> The following changes since commit 186ac05f749c69e98030f037aa930ff2bc4ad7=
fb:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-p=
ull-request' into staging (2018-11-13 11:45:16 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-fixes-for-3.1-141=
118-1
>
> for you to fetch changes up to 1f442da51e088160e892c4e059c154eec3f058c5:
>
>   tests/tcg/multiarch: fix 32bit linux-test on 64bit host (2018-11-14 11:=
07:06 +0000)
>
> ----------------------------------------------------------------
> Testing tweaks:
>
>   - split MacOSX build
>   - fix for readdir() failures in check-tcg
>
Applied, thanks.

-- PMM
