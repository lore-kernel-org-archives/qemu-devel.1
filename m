Received: from eggs.gnu.org ([209.51.188.92]:35366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpB4M-00072V-0L
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpB4G-0004aw-08
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:03:45 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:39369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpB4C-0004XY-Nn
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:03:38 -0500
Received: by mail-ot1-x336.google.com with SMTP id n8so2570428otl.6
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 04:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20190128194351.14679-1-ehabkost@redhat.com>
In-Reply-To: <20190128194351.14679-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 12:03:19 +0000
Message-ID: <CAFEAcA8qi6_GuYOnzGwyXGP0_4rW3tNE07zzF0FSWyk+DKBEFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Machine queue, 2019-01-28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

On Mon, 28 Jan 2019 at 19:43, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 5f39a91dbd9a186edb999afd4d17524f4b1da14f:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-01-28 12:54:06 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 21d1683690e048663855dd6feb3034ab7c5039bc:
>
>   hostmem: add more information in error messages (2019-01-28 15:52:05 -0200)
>
> ----------------------------------------------------------------
> Machine queue, 2019-01-28
>
> * Fix small leak on NUMA code
> * Improve memory backend error messages
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
