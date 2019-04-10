Received: from eggs.gnu.org ([209.51.188.92]:39530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hE9WY-0000Rs-Tp
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hE9WX-00026k-3K
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:28:06 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hE9WU-000226-T9
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:28:03 -0400
Received: by mail-oi1-x241.google.com with SMTP id v7so1155527oie.8
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 02:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190409235401.12671-1-alistair.francis@wdc.com>
In-Reply-To: <20190409235401.12671-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 10:27:49 +0100
Message-ID: <CAFEAcA9UxJv4qLz9syMiSgZ5h3zwFUsdPH72DDXV6JhtqriG_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] device-tree queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>

On Wed, 10 Apr 2019 at 00:55, Alistair Francis <Alistair.Francis@wdc.com> wrote:
>
> The following changes since commit f151f8aca5cf5da24f6eb743a55a2233091ae532:
>
>   migration/ram.c: Fix use-after-free in multifd_recv_unfill_packet() (2019-04-09 20:46:34 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-device-tree-20190409-1
>
> for you to fetch changes up to 065e6298a75164b4347682b63381dbe752c2b156:
>
>   device_tree: Fix integer overflowing in load_device_tree() (2019-04-09 16:35:40 -0700)
>
> ----------------------------------------------------------------
> Single device tree fix for 4.0
>
> A single patch to avoid an overflow when loading device trees.
>
> ----------------------------------------------------------------
> Markus Armbruster (1):
>       device_tree: Fix integer overflowing in load_device_tree()

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
