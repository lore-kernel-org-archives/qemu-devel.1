Received: from eggs.gnu.org ([2001:4830:134:3::10]:60181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLr4x-0003NR-3O
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLr4w-0007W1-74
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:18:55 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLr4w-0007VZ-1y
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:18:54 -0400
Received: by mail-oi0-x241.google.com with SMTP id c203-v6so1585451oib.7
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 07:18:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 15:18:33 +0100
Message-ID: <CAFEAcA9U4CyMSmLdNdPNXbrWaxN=CMhVY-FD=fr-SMrLFdi2Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/28] pc, pci, virtio, vhost: fixes,
 features
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

On 23 May 2018 at 15:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd466d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-05-22 09:43:58 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 63b88968f139b6a77f2f81e6f1eedf70c0170a85:
>
>   intel-iommu: rework the page walk logic (2018-05-23 17:34:05 +0300)
>
> ----------------------------------------------------------------
> pc, pci, virtio, vhost: fixes, features
>
> Beginning of merging vDPA, new PCI ID, a new virtio balloon stat, intel
> iommu rework fixing a couple of security problems (no CVEs yet), fixes
> all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
