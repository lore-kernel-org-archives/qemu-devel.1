Received: from eggs.gnu.org ([2001:4830:134:3::10]:41333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeOOk-0005wP-6m
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeOOj-0005cp-LS
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:59:42 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eeOOj-0005cU-HY
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:59:41 -0500
Received: by mail-ot0-x243.google.com with SMTP id x15so4172264ote.1
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 08:59:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180122160048.29571-1-stefanha@redhat.com>
References: <20180122160048.29571-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Jan 2018 16:59:20 +0000
Message-ID: <CAFEAcA-WdnbLTnDgONskNW6aBLYgUChnGpW-MK2cuXcVm9OL7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/6] Block patches
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

On 22 January 2018 at 16:00, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc78f:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-01-19 16:35:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to bcbb3866da19cce4360c828b6ec1c2a137757927:
>
>   block/parallels: add backing support to readv/writev (2018-01-22 14:02:33 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> v2:
>  * Drop merge failure from a previous pull request that broke virtio-blk on ARM
>    guests
>  * Add Parallels XML patch series
>

Applied, thanks.

-- PMM
