Received: from eggs.gnu.org ([2001:4830:134:3::10]:37309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csXbj-0001bL-Ju
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csXbi-0001r2-Kp
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:35:03 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csXbi-0001oe-Em
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:35:02 -0400
Received: by mail-wr0-x22b.google.com with SMTP id u1so64957749wra.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 09:35:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490621317-25483-1-git-send-email-kraxel@redhat.com>
References: <1490621317-25483-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 17:34:40 +0100
Message-ID: <CAFEAcA_7uWM01RLC+h-KchQgGgmjFiOv9rgRtT0Nj5s_n7uCOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/5] fixes for 2.9: vga, egl, cirrus,
 virtio-input.
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

On 27 March 2017 at 14:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Bugfix collection for 2.9, ui, vga, input.
>
> please pull,
>   Gerd
>
> The following changes since commit ea2afcf5b6727a577cf561fd8fe0d8c397ecc927:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-03-24 14:14:18 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-fixes-20170327-1
>
> for you to fetch changes up to e5766eb40453b1d22815fc5482802688ff184006:
>
>   vnc: fix reverse mode (2017-03-27 12:16:02 +0200)
>
> ----------------------------------------------------------------
> fixes for 2.9: vga, egl, cirrus, virtio-input.
>
> ----------------------------------------------------------------
> Gerd Hoffmann (3):
>       cirrus: fix PUTPIXEL macro
>       ui/egl-helpers: fix egl 1.5 display init
>       vnc: fix reverse mode
>
> Ladi Prosek (2):
>       virtio-input: free event queue when finalizing
>       virtio-input: fix eventq batching

Applied, thanks.

-- PMM
