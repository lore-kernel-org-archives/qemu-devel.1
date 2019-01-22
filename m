Received: from eggs.gnu.org ([209.51.188.92]:45373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1ns-0007pl-3e
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1e7-0001I6-5O
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:23:41 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:35488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1e5-00010S-3F
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:23:37 -0500
Received: by mail-oi1-x229.google.com with SMTP id v6so18415821oif.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20190121224907.26634-1-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 19:23:17 +0000
Message-ID: <CAFEAcA-JK8F_GTjaeJJERrK-hXbC_ArsDamhWd5KgF5hr6BVtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] NBD patches through 2019-01-21
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

On Mon, 21 Jan 2019 at 22:51, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 166609e6070fab3424510ac7292ecb585f8b80fb:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-january-17-2019-v2' into staging (2019-01-21 17:53:28 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-01-21
>
> for you to fetch changes up to ddd09448fd833d646952c769ae9ce3d39bee989f:
>
>   iotests: Enhance 223, 233 to cover 'qemu-nbd --list' (2019-01-21 15:49:52 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2019-01-21
>
> Add 'qemu-nbd --list' for probing a remote NBD server's advertisements.
>
> - Eric Blake: 0/21 nbd: add qemu-nbd --list
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
