Received: from eggs.gnu.org ([2001:4830:134:3::10]:44820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKjUX-0000Db-M1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKjUW-0007QQ-Tj
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:56:09 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKjUW-0007Pq-KL
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:56:08 -0400
Received: by mail-wr0-x232.google.com with SMTP id v104so131845725wrb.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 03:56:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496950567-26343-1-git-send-email-mst@redhat.com>
References: <1496950567-26343-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 11:55:45 +0100
Message-ID: <CAFEAcA-M=nxRe1JZH_yhe-Br-QSoM_BXRq7-H05x7KYLWMz5Xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] pc, pci, vhost: fixes
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

On 8 June 2017 at 20:36, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 64175afc695c0672876fbbfc31b299c86d562cb4:
>
>   arm_gicv3: Fix ICC_BPR1 reset value when EL3 not implemented (2017-06-07 17:21:44 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to bc277a52fbea1532d1adf30ba0edf15ab3dcdead:
>
>   hw/pcie: fix the generic pcie root port to support migration (2017-06-08 22:02:37 +0300)
>
> ----------------------------------------------------------------
> pc, pci, vhost: fixes
>
> Some fixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
