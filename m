Received: from eggs.gnu.org ([2001:4830:134:3::10]:36522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvRor-0003YL-56
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvRoq-0002a1-4a
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:00:37 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvRop-0002Yg-Sy
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:00:36 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k6so215633145wre.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 10:00:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491320063-12719-1-git-send-email-mst@redhat.com>
References: <1491320063-12719-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 18:00:13 +0100
Message-ID: <CAFEAcA--6i=eBcvh62sB-p4_AKqotUPz5vc98Tzbi2kVSCw9EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] pci: fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jeff Cody <jcody@redhat.com>

On 4 April 2017 at 16:35, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 87cc4c61020addea6a001b94b662596b1896d1b3:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-04-04 11:40:55 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 193982c6f9424779b53a168fe32ebc30a776cbf1:
>
>   pci: Only unmap bus_master_enabled_region if was added previously (2017-04-04 18:32:25 +0300)
>
> ----------------------------------------------------------------
> pci: fix
>
> A single bugfix for a error handling issue in pci.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pci: Only unmap bus_master_enabled_region if was added previously

Applied, thanks.

-- PMM
