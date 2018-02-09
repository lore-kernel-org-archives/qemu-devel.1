Received: from eggs.gnu.org ([2001:4830:134:3::10]:54568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ekCjS-0007hS-8O
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ekCjR-0001fy-7P
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:45:06 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:34670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ekCjR-0001fq-1A
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:45:05 -0500
Received: by mail-oi0-x229.google.com with SMTP id k15so6696085oib.1
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 09:45:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209141514.18840-1-alex.bennee@linaro.org>
References: <20180209141514.18840-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2018 17:44:43 +0000
Message-ID: <CAFEAcA9M5fKPFn0_2cC=F07Mkew+JkpogOTVAd8UE_TVpj=D6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] Travis speed-up
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

On 9 February 2018 at 14:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> The following changes since commit 04bb7fe2bf55bdf66d5b7a5a719b40bbb40481=
78:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180208' into =
staging (2018-02-08 17:41:15 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-travis-speedup-090218-1
>
> for you to fetch changes up to 04200a1674bfc20784f1fc105cbc22bd9be779e8:
>
>   .travis.yml: add --disable-linux-user for some jobs (2018-02-09 14:09:2=
4 +0000)
>
> ----------------------------------------------------------------
> One patch to mitigate Travis timeouts
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (1):
>       .travis.yml: add --disable-linux-user for some jobs
>
>  .travis.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Applied, thanks.

-- PMM
