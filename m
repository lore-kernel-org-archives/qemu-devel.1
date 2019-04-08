Received: from eggs.gnu.org ([209.51.188.92]:47840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDQvA-0006SU-PK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDQv4-0002Vp-8B
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:50:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDQux-0002GK-Qc
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:50:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id e5so11379739otk.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190405231225.30165-1-mst@redhat.com>
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2019 10:49:32 +0100
Message-ID: <CAFEAcA9SLSJBhZV1bfdv3wA80mDLZf1bTPvQgGA=Rk7OMOVfOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] pci, pc, virtio: fixes
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

On Sat, 6 Apr 2019 at 00:12, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 436960c95946007aca713330e7a488a6f2e0696f:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/filemon-next-pull-request' into staging (2019-04-02 14:52:17 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 81fb1e646e4da29f8e1639022241323b956b67e4:
>
>   intel_iommu: Drop extended root field (2019-04-02 11:49:14 -0400)
>
> ----------------------------------------------------------------
> pci, pc, virtio: fixes
>
> intel-iommu fixes
> virtio typo fixes
> linker: a couple of asserts for consistency/security
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
