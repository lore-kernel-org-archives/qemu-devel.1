Received: from eggs.gnu.org ([2001:4830:134:3::10]:34162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzNDx-0001Fg-3E
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzNDw-0002Ry-6I
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:27:01 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:56060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dzNDv-0002R2-Tu
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:27:00 -0400
Received: by mail-wr0-x229.google.com with SMTP id l39so6309686wrl.12
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:26:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170929102201.15408-1-kraxel@redhat.com>
References: <20170929102201.15408-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Oct 2017 14:26:37 +0100
Message-ID: <CAFEAcA-7FCEYkovK4nZoJfn5-aRY15qFnu_LZxA2iNFUnGoM5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Ui 20170929 patches
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

On 29 September 2017 at 11:21, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit ab161529261928ae7f3556e3220829c34b2686ec:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170927a' into staging (2017-09-27 22:44:51 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20170929-pull-request
>
> for you to fetch changes up to 7364dbdabb7824d5bde1e341bb6d928282f01c83:
>
>   ui: add tracing of VNC authentication process (2017-09-29 10:36:34 +0200)
>
> ----------------------------------------------------------------
> ui and input patches.
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (2):
>   ui: add tracing of VNC operations related to QIOChannel
>   ui: add tracing of VNC authentication process
>
> Gerd Hoffmann (3):
>   console: purge curses bits from console.h
>   egl: misc framebuffer helper improvements.
>   virtio-input: send rel-wheel events for wheel buttons

Applied, thanks.

-- PMM
