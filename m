Received: from eggs.gnu.org ([2001:4830:134:3::10]:53372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPmj6-0006BO-La
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPmj5-0007oi-Uf
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:28:36 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPmj5-0007oX-Pr
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:28:35 -0400
Received: by mail-oi0-x241.google.com with SMTP id k5-v6so27936788oiw.0
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 03:28:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 11:28:14 +0100
Message-ID: <CAFEAcA_weoW3XS2dppdc=jwpCSSAaiTxaQDxsBBKdjjA4aY_Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/31] acpi, vhost, misc: fixes, features
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

On 1 June 2018 at 17:26, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 63b88968f139b6a77f2f81e6f1eedf70c0170a85:
>
>   intel-iommu: rework the page walk logic (2018-05-23 17:34:05 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 25b1d45a1975fd8624c37b5bf42e8502ccf53460:
>
>   vhost-blk: turn on pre-defined RO feature bit (2018-06-01 19:20:38 +0300)
>
> ----------------------------------------------------------------
> acpi, vhost, misc: fixes, features
>
> vDPA support, fix to vhost blk RO bit handling, some include path
> cleanups, NFIT ACPI table.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
