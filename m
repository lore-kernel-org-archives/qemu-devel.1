Received: from eggs.gnu.org ([2001:4830:134:3::10]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elDiP-0003Qi-P4
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elDiN-0007Ub-RG
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:00:13 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:46427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elDiN-0007U6-MT
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:00:11 -0500
Received: by mail-oi0-x22e.google.com with SMTP id x21so11078580oie.13
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 05:00:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209190824.32221-1-eblake@redhat.com>
References: <20180209190824.32221-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Feb 2018 12:59:50 +0000
Message-ID: <CAFEAcA-0URsE9h3FQTRYWq76_4g_Lik4at=XLwnAuq2xfYmvuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] NBD patches through 2018-02-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 February 2018 at 19:08, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit c7b02d7d032d6022060e4b393827c963c93ce63f:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-090218-1' into staging (2018-02-09 16:12:34 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-02-09
>
> for you to fetch changes up to e24d813b29d3a478a9309078487efc8ce8599f22:
>
>   block: Simplify bdrv_can_write_zeroes_with_unmap() (2018-02-09 12:32:44 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2018-02-09
>
> - Vladimir Sementsov-Ogievskiy: iotests: 205: support luks format
> - Eric Blake: block: Simplify bdrv_can_write_zeroes_with_unmap()
>

Applied, thanks.

-- PMM
