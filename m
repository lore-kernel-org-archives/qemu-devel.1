Received: from eggs.gnu.org ([209.51.188.92]:42686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghdCb-0007RF-Up
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghdCY-0008OT-5u
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:29:04 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:37115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghdCW-0008N0-Rw
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:29:00 -0500
Received: by mail-ot1-x333.google.com with SMTP id s13so1945246otq.4
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20190109130844.5172-1-laurent@vivier.eu>
In-Reply-To: <20190109130844.5172-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jan 2019 16:28:48 +0000
Message-ID: <CAFEAcA86x-Mp+uf5bj=FkcgXdVpmwZ=hquTNZv6_+UBd7avKaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Trivial patches patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=83=C2=A9?= <philmd@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-ppc <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, John Snow <jsnow@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 9 Jan 2019 at 13:23, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22f0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-request' into staging (2019-01-08 16:07:32 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-patches-pull-request
>
> for you to fetch changes up to 34bec7a8d04f23d6258dcf338894956b945673a5:
>
>   ioapic: use TYPE_FOO MACRO than constant string (2019-01-09 11:33:47 +0100)
>
> ----------------------------------------------------------------
> Trivial patches for 4.0 (2019-01-09)
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
