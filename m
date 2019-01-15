Received: from eggs.gnu.org ([209.51.188.92]:33682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjN3j-0007I8-U7
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjN3h-00050r-3v
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:39:07 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:32785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gjN3g-00050G-Dx
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:39:05 -0500
Received: by mail-oi1-x22d.google.com with SMTP id c206so1894281oib.0
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 03:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20190114150129.1013-1-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Jan 2019 11:38:51 +0000
Message-ID: <CAFEAcA_Mh17ktcOMqVSR7LZP4QP+VpJPcpR5zjV1-rmeWS7T+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/21] misc testing fixes for Travis and
 docker
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

On Mon, 14 Jan 2019 at 15:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b=
16:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-=
part2' into staging (2019-01-14 11:41:43 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-140119-1
>
> for you to fetch changes up to a36270a4d1589b1ed309065fc8b3fe0ac8d6869d:
>
>   Revert "tests: Disable qht-bench parallel test when using gprof" (2019-=
01-14 14:55:32 +0000)
>
> ----------------------------------------------------------------
> A bunch of fixes for testing:
>
>   - Various Travis updates
>   - "stable" SID snapshot for docker
>   - avoid :latest docker tags
>   - g_usleep fix for some tests
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
