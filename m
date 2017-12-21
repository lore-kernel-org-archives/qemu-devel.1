Received: from eggs.gnu.org ([2001:4830:134:3::10]:47746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS7Qr-0000TP-FG
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS7Qq-00016g-MV
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:27:09 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS7Qq-00016T-H3
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:27:08 -0500
Received: by mail-oi0-x242.google.com with SMTP id s9so17642644oie.5
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 12:27:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 20:26:47 +0000
Message-ID: <CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 December 2017 at 14:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 2babfe0c9241c239272a03fec785165a50e8288c:
>
>   Update version for v2.11.0-rc4 release (2017-12-05 16:36:46 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 664ed92706ff6e66fa278c3163b5387f11d6daca:
>
>   smbus: do not immediately complete commands (2017-12-21 16:24:44 +0200)
>
> ----------------------------------------------------------------
> pc, pci, virtio: features, fixes, cleanups
>
> A bunch of fixes, cleanus and new features all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Conflicts in hw/block/nvme.c -- can you fix and resend, please?

thanks
-- PMM
