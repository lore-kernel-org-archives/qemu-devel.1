Received: from eggs.gnu.org ([2001:4830:134:3::10]:37441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faHts-0003FB-WD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faHtp-00067E-1U
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:47:09 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faHto-00066t-Pc
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:47:04 -0400
Received: by mail-oi0-x244.google.com with SMTP id b15-v6so2514198oib.10
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 02:47:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702234631.12268-1-mst@redhat.com>
References: <20180702234631.12268-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 10:46:43 +0100
Message-ID: <CAFEAcA_EQAt1+VmdeNS54iGkqsmyJ_PZEjkq-4hLrCgxA9L9BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] pc, virtio: fixes
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

On 3 July 2018 at 00:48, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 00928a421d47f49691cace1207481b7aad31b1f1:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180626' into staging (2018-06-26 18:23:49 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 5d9c9ea22ab4f3b3ee497523e34b6f4d3281f62d:
>
>   virtio-rng: process pending requests on DRIVER_OK (2018-06-28 04:46:16 +0300)
>
> ----------------------------------------------------------------
> pc, virtio: fixes
>
> A couple of fixes to amd iommu, and a fix to virtio iommu.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
Applied, thanks.

-- PMM
