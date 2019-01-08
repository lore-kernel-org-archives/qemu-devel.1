Received: from eggs.gnu.org ([209.51.188.92]:37721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gguv8-0003Hg-7g
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gguv4-0006jf-K7
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:12:04 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:46631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gguv4-0006bK-EG
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:12:02 -0500
Received: by mail-oi1-x234.google.com with SMTP id x202so3888968oif.13
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 09:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20190108155354.8591-1-kraxel@redhat.com>
In-Reply-To: <20190108155354.8591-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 17:11:47 +0000
Message-ID: <CAFEAcA-xAohKZWZJL2F1tUN=O-B+2jO-cVKB-+aVSKOUgVAPBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Usb 20190108 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 8 Jan 2019 at 15:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e59dbbac0364344a3ad84c3497a98c56003d3fb8:
>
>   Merge remote-tracking branch 'remotes/philmd/tags/fw_cfg-20190104-pull-request' into staging (2019-01-04 18:23:13 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190108-pull-request
>
> for you to fetch changes up to efce3175fd572e4d98af0b50ae9cb8d7b808f034:
>
>   usb: move ehci_create_ich9_with_companions to hw/i386 (2019-01-08 12:43:41 +0100)
>
> ----------------------------------------------------------------
> usb: generic sysbus ehci, bugfixes.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
