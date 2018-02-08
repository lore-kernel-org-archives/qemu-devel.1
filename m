Received: from eggs.gnu.org ([2001:4830:134:3::10]:34276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejjGL-0004bD-Kf
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejjGK-0005NV-RD
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:17:05 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:35306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejjGK-0005NO-L6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:17:04 -0500
Received: by mail-ot0-x22b.google.com with SMTP id a2so3826969otf.2
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 02:17:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180207163322.25820-1-jsnow@redhat.com>
References: <20180207163322.25820-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 10:16:43 +0000
Message-ID: <CAFEAcA-jt0CD4T3mzTrT2Fsn3mGpXjjA3z=v9L6hz88z+aEggg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2018 at 16:33, John Snow <jsnow@redhat.com> wrote:
> The following changes since commit 0833df03f4206a6cf416fbb3d380fa95c8e61fba:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180206a' into staging (2018-02-07 12:07:23 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to 29e1d473ccb0703044541959df443c175ea5f5da:
>
>   ide-test: test trim requests (2018-02-07 11:25:22 -0500)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Anton Nefedov (1):
>   ide-test: test trim requests
>
>  tests/ide-test.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>

Applied, thanks.

-- PMM
