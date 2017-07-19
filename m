Received: from eggs.gnu.org ([2001:4830:134:3::10]:33340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXsBv-0007Pq-2Z
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXsBu-0002EO-8u
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:51:15 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:38562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXsBu-0002E1-0O
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:51:14 -0400
Received: by mail-wr0-x233.google.com with SMTP id f21so4504594wrf.5
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 09:51:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1707181519030.17537@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1707181519030.17537@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 17:50:52 +0100
Message-ID: <CAFEAcA_M286Z3e-O2YV9hZpV15hcVM+CvjgCZz1fbKWgVdJ_NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.0 0/7] please pull xen-20170718-tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>

On 18 July 2017 at 23:20, Stefano Stabellini <sstabellini@kernel.org> wrote:
> The following changes since commit f9dada2baabb639feb988b3a564df7a06d214e18:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-07-18 20:29:36 +0100)
>
> are available in the git repository at:
>
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170718-tag
>
> for you to fetch changes up to 331b5189d756d431b1d18ae7097527ba3d3ea809:
>
>   xen: don't use xenstore to save/restore physmap anymore (2017-07-18 14:16:52 -0700)
>
> ----------------------------------------------------------------
> Xen 2017/07/18
>
> ----------------------------------------------------------------
> Igor Druzhinin (4):
>       xen: move physmap saving into a separate function
>       xen/mapcache: add an ability to create dummy mappings
>       xen/mapcache: introduce xen_replace_cache_entry()
>       xen: don't use xenstore to save/restore physmap anymore
>
> Peter Maydell (1):
>       xen_pt_msi.c: Check for xen_host_pci_get_* failures in xen_pt_msix_init()
>
> Stefano Stabellini (1):
>       xen-platform: separate unplugging of NVMe disks
>
> Xiong Zhang (1):
>       hw/xen: Set emu_mask for igd_opregion register

Applied, thanks.

-- PMM
