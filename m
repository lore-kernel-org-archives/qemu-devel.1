Received: from eggs.gnu.org ([209.51.188.92]:41793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpHZI-0000qj-A6
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:00:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpHZB-0007aN-MC
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:00:07 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpHZ9-0007PM-Lk
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:00:00 -0500
Received: by mail-oi1-x241.google.com with SMTP id m6so3630721oig.11
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 10:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20190130132214.25493-1-laurent@vivier.eu>
In-Reply-To: <20190130132214.25493-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 18:59:35 +0000
Message-ID: <CAFEAcA-n+j53k-SqX_w22vDY2L=AAQWFoLzR2XqWo-AjzBDAFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial branch patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Jiri Slaby <jslaby@suse.cz>, Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, qemu-s390x <qemu-s390x@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, 30 Jan 2019 at 13:30, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit b4fbe1f65a4769c09e6bf2d79fc84360f840f40e:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190129' into staging (2019-01-29 12:00:19 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to 95b3c9cfd5eaaa4a2a4afa1eaf09612a94ade1da:
>
>   virtio-blk: remove duplicate definition of VirtIOBlock *s pointer (2019-01-30 14:20:18 +0100)
>
> ----------------------------------------------------------------
> - add device category (edu, i8042, sd memory card)
> - code clean-up
> - LGPL information clean-up
> - fix typo (acpi)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
