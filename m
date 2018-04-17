Received: from eggs.gnu.org ([2001:4830:134:3::10]:57680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8Ncf-0002su-5T
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8NcY-0001Pl-TM
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:14:01 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8NcY-0001JJ-LE
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:13:54 -0400
Received: by mail-oi0-x243.google.com with SMTP id n65-v6so4181562oig.6
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 03:13:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523895458-475479-1-git-send-email-mst@redhat.com>
References: <1523895458-475479-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 11:13:33 +0100
Message-ID: <CAFEAcA-4Nn1X4hisSP_F+7SVdKp2uns4BebLZZuOwP75eqy9Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] vhost: bugfix
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

On 16 April 2018 at 17:47, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 38e83a71d02e026d4a6d0ab1ef9855c4924c2c68:
>
>   Update version for v2.12.0-rc3 release (2018-04-11 19:03:24 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to aebbdbee559389a9f0d0e56670b9332534b6bb9b:
>
>   vhost: do not verify ring mappings when IOMMU is enabled (2018-04-16 19:11:38 +0300)
>
> ----------------------------------------------------------------
> vhost: bugfix
>
> This fixes a regression in vhost.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Jason Wang (1):
>       vhost: do not verify ring mappings when IOMMU is enabled
>
>  hw/virtio/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- PMM
