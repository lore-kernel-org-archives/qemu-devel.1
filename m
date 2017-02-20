Received: from eggs.gnu.org ([2001:4830:134:3::10]:40302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfmZH-0007rR-Cg
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfmZG-0003c4-DI
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:55:47 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfmZG-0003bs-6D
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:55:46 -0500
Received: by mail-wm0-x232.google.com with SMTP id c85so76790504wmi.1
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 03:55:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487361200-29966-1-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 11:55:24 +0000
Message-ID: <CAFEAcA-fOP8S61-0c-1CPJEEY4Dbq5bhpe2xQEH7jH9ZFmK1WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/23] virtio, pci: fixes, features
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

On 17 February 2017 at 19:53, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit ad584d37f2a86b392c25f3f00cc1f1532676c2d1:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-02-16 17:46:52 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 7e58326ad7e79b8c5dbcc6f24e9dc1523d84c11b:
>
>   intel_iommu: vtd_slpt_level_shift check level (2017-02-17 21:52:31 +0200)
>
> ----------------------------------------------------------------
> virtio, pci: fixes, features
>
> virtio is using region caches for performance
> iommu support for IOTLBs
> misc fixes
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
