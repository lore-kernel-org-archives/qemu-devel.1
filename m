Received: from eggs.gnu.org ([209.51.188.92]:39408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYgJ-0005Z2-GC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYgI-0005Nz-Hu
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:56:55 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:46214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYgG-0005K2-9g
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:56:53 -0400
Received: by mail-oi1-x22c.google.com with SMTP id d62so4385173oib.13
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190503065954.17069-1-kraxel@redhat.com>
In-Reply-To: <20190503065954.17069-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:56:35 +0100
Message-ID: <CAFEAcA8yBguOgjfCHa8RT=gFev2TTUAuG-Z3hNtDgFYrdZ16eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Usb 20190503 v2 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 3 May 2019 at 08:02, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit f75d15231e56cb0f2bafe19faf1229c459a60731:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-04-30 17:06:57 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190503-v2-pull-request
>
> for you to fetch changes up to ccb799313a5926a6aa49018bbc67fe6165fad7f3:
>
>   hw/usb: avoid format truncation warning when formatting port name (2019-05-03 08:56:58 +0200)
>
> ----------------------------------------------------------------
> usb: bugfixes for mtp and xhci, split ohci-pci.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
