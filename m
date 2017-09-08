Received: from eggs.gnu.org ([2001:4830:134:3::10]:52648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqLan-0005rw-RT
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqLam-0003BD-UL
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:53:17 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqLam-0003AZ-N5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:53:16 -0400
Received: by mail-wr0-x232.google.com with SMTP id m18so5434033wrm.2
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 08:53:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 16:52:54 +0100
Message-ID: <CAFEAcA92Jjzn7_0Weu1B30xiPXXcF=pGws8CC-VMTwuYe76chg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] pc, pci,
 virtio: patches queued before 2.10
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

On 8 September 2017 at 15:18, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 74bbfe024da80a50dbe51fbb17f219d2f3e4d2dd:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2017-09-08 12:57:28 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 6f6f4aec749ba9a4fb58c7c20536a61b0381ff35:
>
>   fw_cfg: rename read callback (2017-09-08 16:15:17 +0300)
>
> ----------------------------------------------------------------
> pc, pci, virtio: patches queued before 2.10
>
> A bunch of stuff that was posted before the 2.10 timeframe,
> mostly fixes/cleanups.  New PCI bridges.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
