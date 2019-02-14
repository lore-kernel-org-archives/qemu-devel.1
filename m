Received: from eggs.gnu.org ([209.51.188.92]:33906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guL4B-0002HG-Ig
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guL1L-0006W6-C8
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:42:00 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:42800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guL1L-0006TK-5B
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:41:59 -0500
Received: by mail-ot1-x32b.google.com with SMTP id i5so11882176oto.9
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20190214043322.2354-1-stefanha@redhat.com>
In-Reply-To: <20190214043322.2354-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 17:41:47 +0000
Message-ID: <CAFEAcA9ymZO9FHXPEDTHC9Qm9ShvrAhmHBX1jF2dnH38dwpG4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 14 Feb 2019 at 04:33, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc06:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-02-12 10:53:37 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 42824b4d16da56a50ff4027f6cd22378e0e2666e:
>
>   virtio-blk: set correct config size for the host driver (2019-02-13 16:18:17 +0800)
>
> ----------------------------------------------------------------
> Pull request
>
> Fix a virtio-blk migration regression.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
