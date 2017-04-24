Received: from eggs.gnu.org ([2001:4830:134:3::10]:45034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2gDQ-0006IG-VO
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2gDQ-0005LE-5s
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:47:53 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:32771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2gDP-0005L4-VX
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:47:52 -0400
Received: by mail-wr0-x22e.google.com with SMTP id w50so70889191wrc.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 08:47:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424121708.31953-1-kraxel@redhat.com>
References: <20170424121708.31953-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 16:47:30 +0100
Message-ID: <CAFEAcA88VKJQws1hrNei4H8PUQXC9TDbzQfoz+LOBaMsUytvJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/13] vga patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 April 2017 at 13:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here comes the vga patch queue.  It brings the first batch of display
> update race fixes, xres+yres properties for qxl and virtio, also some
> cleanups piled up during the 2.9 freeze.
>
> please pull,
>   Gerd
>
> The following changes since commit 32c7e0ab755745e961f1772e95cac381cc68769d:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170421' into staging (2017-04-21 15:59:27 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/pull-vga-20170424-1
>
> for you to fetch changes up to 729abb6a920e80c3866f60d1638f08f2eba98a9a:
>
>   virtio-gpu: add xres and yres properties (2017-04-24 10:12:28 +0200)
>
> ----------------------------------------------------------------
> fix display update races, part one.
> add xres + yres properties to qxl and virtio.
> misc fixes and cleanups.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
