Received: from eggs.gnu.org ([209.51.188.92]:42161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grmrr-0000hU-6L
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grmrm-0007S3-B7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:49:36 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:40618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grmre-0007Ky-Nq
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:49:27 -0500
Received: by mail-ot1-x333.google.com with SMTP id s5so878562oth.7
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 08:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20190206152807.31896-1-laurent@vivier.eu>
In-Reply-To: <20190206152807.31896-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 16:49:10 +0000
Message-ID: <CAFEAcA_-peVcup1ARQmKyxyxPQwSYWswO6tDhGcvNENW3ceRhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Trivial patches patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Anthony Green <green@moxielogic.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Andrzej Zaborowski <balrogg@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Wed, 6 Feb 2019 at 15:28, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd507:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190205' into staging (2019-02-05 18:25:07 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-patches-pull-request
>
> for you to fetch changes up to e67e91b4b55331973f783ca89790ee9f7861ced1:
>
>   hw/input/tsc210x: Fix building with no verbosity (2019-02-06 15:57:06 +0100)
>
> ----------------------------------------------------------------
> Trivial patches:
> * Update copyright
> * Fix LGPL in target/moxie
> * configure portability fix
> * Drop useless inclusion of "hw/i386/pc.h"
> * Mark the cpu-cluster device with user_creatable = false
> * tsc210x: Fix building with no verbosity
>
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
