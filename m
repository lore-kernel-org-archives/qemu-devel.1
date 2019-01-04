Received: from eggs.gnu.org ([208.118.235.92]:47687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfQsQ-0003BR-Sd
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfQsP-00056O-VX
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:55:10 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:41902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfQsP-00055l-QG
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:55:09 -0500
Received: by mail-oi1-x22c.google.com with SMTP id j21so30530763oii.8
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 06:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20190104112145.12413-1-stefanha@redhat.com>
In-Reply-To: <20190104112145.12413-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 14:54:58 +0000
Message-ID: <CAFEAcA_jNbE1uue8uoYrmzooPL_oAbav0MX+jSEcAO=RQGW3Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On Fri, 4 Jan 2019 at 11:21, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 20d6c7312f1b812bb9c750f4087f69ac8485cc90:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-part1' into staging (2019-01-03 13:26:30 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 39a0408e768cd00142f5b57d27ab234282bf4df5:
>
>   dmg: don't skip zero chunk (2019-01-04 11:15:09 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> Bug fixes for the .dmg image file format.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
