Received: from eggs.gnu.org ([2001:4830:134:3::10]:35213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs41K-0007Q3-0w
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs41J-0007qj-Bk
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:36:17 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fs41J-0007qR-4L
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:36:17 -0400
Received: by mail-oi0-x241.google.com with SMTP id v8-v6so31159485oie.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 03:36:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820104045.133968-1-mst@redhat.com>
References: <20180820104045.133968-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 11:35:55 +0100
Message-ID: <CAFEAcA-FpGRT4TxR7-QLN0SYGsCRZ-jU9L=T=xWaVi0dB-HZLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] pc: fixes
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

On 20 August 2018 at 21:24, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:
>
>   Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 56eb90af39abf66c0e80588a9f50c31e7df7320b:
>
>   migration/ram: ensure write persistence on loading all data to PMEM. (2018-08-10 13:29:39 +0300)
>
> ----------------------------------------------------------------
> pc: fixes
>
> This includes nvdimm persistence fixes queued before the release.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

-- PMM
