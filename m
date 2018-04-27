Received: from eggs.gnu.org ([2001:4830:134:3::10]:60703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC1Xx-0004Xb-7J
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC1Xw-0003YK-Cx
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:28:13 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC1Xw-0003Y8-7Y
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:28:12 -0400
Received: by mail-oi0-x243.google.com with SMTP id 126-v6so1276305oig.0
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 04:28:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427095434.14013-1-kraxel@redhat.com>
References: <20180427095434.14013-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 12:27:51 +0100
Message-ID: <CAFEAcA8xUwnofNbT2y6CSui1aAkhYVkmuEw_SzTnvb8663dp6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Ui 20180427 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 27 April 2018 at 10:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit b8846a4d6352b2a1d2012f8b3b9115640524aeda:
>
>   vl.c: new function serial_max_hds() (2018-04-26 13:58:29 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180427-pull-request
>
> for you to fetch changes up to 8983e3e35033ecb9234725c2bba65f020824969b:
>
>   ui: introduce vfio_display_reset (2018-04-27 11:36:34 +0200)
>
> ----------------------------------------------------------------
> vnc: fix use-after-free.
> sdl2: gles support.
> vfio-display: add reset support.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
