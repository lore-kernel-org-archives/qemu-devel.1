Received: from eggs.gnu.org ([2001:4830:134:3::10]:56557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eReIe-0005EW-Sg
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eReIZ-0007Tv-50
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:44 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:33829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eReIZ-0007ST-0E
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:39 -0500
Received: by mail-oi0-x22d.google.com with SMTP id u193so14593672oie.1
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 05:20:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171219151144.11120-1-stefanha@redhat.com>
References: <20171219151144.11120-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Dec 2017 13:20:17 +0000
Message-ID: <CAFEAcA8N-YmoCsQbC_Pi442HX4v-XLnJwibEuZm_auqDyrkikw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/23] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 December 2017 at 15:11, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit eaefea537b476cb853e2edbdc68e969ec777e4bb:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-12-18 14:17:42 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 7a9dda0d7f9831c2432620dcfefdadbb7ae888dc:
>
>   qemu-iotests: add 203 savevm with IOThreads test (2017-12-19 10:25:09 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> v2:
>  * Fixed incorrect virtio_blk_data_plane_create() local_err refactoring in
>    "hw/block: Use errp directly rather than local_err" that broke virtio-blk
>    over virtio-mmio [Peter]
>

Applied, thanks.

-- PMM
