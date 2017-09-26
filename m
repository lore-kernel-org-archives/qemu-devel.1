Received: from eggs.gnu.org ([2001:4830:134:3::10]:49870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwuu6-00042K-G8
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwuu5-0001yM-Qo
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:48:22 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:56475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwuu5-0001xn-Jb
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:48:21 -0400
Received: by mail-wr0-x22c.google.com with SMTP id r74so13995980wrb.13
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:48:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170925221650.2190-1-richard.henderson@linaro.org>
References: <20170925221650.2190-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2017 19:47:59 +0100
Message-ID: <CAFEAcA8meXGL-Pc37gF8mPU9x_XHJ=4+h+6Qq-uveiPw=QcZ4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] tcg patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 September 2017 at 23:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Just one patch, but should make stable 2.10.1 this week.
>
>
> r~
>
>
> The following changes since commit 460b6c8e581aa06b86f59eebd9e52edfe7adf4=
17:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-09-23 12:55:40 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170925
>
> for you to fetch changes up to 8b81253332b5a3f3c67b6462f39caef47a00dd29:
>
>   accel/tcg/cputlb: avoid recursive BQL (fixes #1706296) (2017-09-25 11:2=
3:30 -0700)
>
> ----------------------------------------------------------------
> BQL bug fix
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (1):
>       accel/tcg/cputlb: avoid recursive BQL (fixes #1706296)

Applied, thanks.

-- PMM
