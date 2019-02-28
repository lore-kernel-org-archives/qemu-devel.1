Received: from eggs.gnu.org ([209.51.188.92]:47053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzKOc-0005Ar-RA
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzKOZ-0002xo-2D
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:02:38 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:33079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzKOX-0002t2-Dp
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:02:33 -0500
Received: by mail-ot1-x32c.google.com with SMTP id q24so17455010otk.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 04:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20190226141201.16999-1-alex.bennee@linaro.org>
In-Reply-To: <20190226141201.16999-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 12:02:19 +0000
Message-ID: <CAFEAcA8+10wH_CrhgyW8A_dcxYi=CYgfmUeeoWx5WVGbDOZr_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] softfloat updates, mostly for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>

On Tue, 26 Feb 2019 at 14:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit ef80b99ce7ffbd66b3efd493f4ca99f8abf59e=
79:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-22=
0219-1' into staging (2019-02-25 14:04:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-fpu-next-260219-1
>
> for you to fetch changes up to bf30e8662cd2ee8b750945591cb34a31784fb994:
>
>   tests/Makefile.include: test all rounding modes of softfloat (2019-02-2=
6 14:08:03 +0000)
>
> ----------------------------------------------------------------
> Softloat updates, mostly in preparation for s390x usage
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
