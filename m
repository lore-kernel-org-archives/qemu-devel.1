Received: from eggs.gnu.org ([2001:4830:134:3::10]:58035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNyMM-0008O9-GI
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNyML-0003r5-Jo
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:25:06 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNyML-0003qn-Cr
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:25:05 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 77so15003904wrb.1
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 02:25:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497628168-30489-1-git-send-email-mst@redhat.com>
References: <1497628168-30489-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 10:24:43 +0100
Message-ID: <CAFEAcA8gLKyrZZFfDBHUk4ROeuahaJmS+jne6pMwAtZ678uzmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] pc: fixes, cleanups, features
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

On 16 June 2017 at 16:49, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit edf8bc98424d62035d5e4c0f39542722d72d7979:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-s390-20170613' into staging (2017-06-15 13:45:15 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 7f3cf2d6e7d1231d854902c9016823961e59d1f4:
>
>   hw/i386: fix nvdimm check error path (2017-06-16 18:44:56 +0300)
>
> ----------------------------------------------------------------
> pc: fixes, cleanups, features
>
> Some fixes and cleanups. Extended TSEG sizes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
