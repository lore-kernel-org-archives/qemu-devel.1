Received: from eggs.gnu.org ([2001:4830:134:3::10]:56840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXQgx-0008Kf-3q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXQgh-0002ht-Nw
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:06:01 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:47026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXQgh-0002hJ-IG
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:05:59 -0500
Received: by mail-ot1-x331.google.com with SMTP id w25so1775666otm.13
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 05:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20181212095252.20349-1-stefanha@redhat.com>
In-Reply-To: <20181212095252.20349-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 13:05:47 +0000
Message-ID: <CAFEAcA9R6S-_=3Ae2aYodnovpWex=B3=8Q5rGAOPO2ewzRpZnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On Wed, 12 Dec 2018 at 09:53, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to e61809ed8ac3a2f68eb1cc231244f84eb06adacf:
>
>   virtio-blk: fix comment for virtio_blk_rw_complete as nalloc is initially -1 (2018-12-12 09:16:55 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> Minor virtio-blk fixes.
>
> ----------------------------------------------------------------
>
> Dongli Zhang (2):
>   virtio-blk: rename iov to out_iov in virtio_blk_handle_request()
>   virtio-blk: fix comment for virtio_blk_rw_complete as nalloc is
>     initially -1
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
