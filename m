Received: from eggs.gnu.org ([2001:4830:134:3::10]:57030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOl5v-0001xh-8q
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOl5p-0006Td-OR
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:04:11 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gOl5p-0006TF-JY
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:04:05 -0500
Received: by mail-oi1-x244.google.com with SMTP id p82-v6so25463581oih.11
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 07:04:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181119142944.29061-1-kwolf@redhat.com>
References: <20181119142944.29061-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 15:03:44 +0000
Message-ID: <CAFEAcA-2iSWwJwg2ztZacFOAxyY1A65s5y-tfTBW8Y21ocDcQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 19 November 2018 at 14:29, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 9436e082de18b2fb2ceed2e9d1beef641ae64f23:
>
>   MAINTAINERS: clarify some of the tags (2018-11-19 11:19:23 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 6d0a4a0fb5c8f10c8eb68b52cfda0082b00ae963:
>
>   iotests: Test file-posix locking and reopen (2018-11-19 14:32:04 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Fix shared permission locks after reopen
> - block: Fix error path for failed .bdrv_reopen_prepare
> - qcow2: Catch invalid allocations when the image becomes too large
> - vvfat/fdc/nvme: Fix segfaults and leaks
>

Applied, thanks.

-- PMM
