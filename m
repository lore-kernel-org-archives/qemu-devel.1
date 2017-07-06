Received: from eggs.gnu.org ([2001:4830:134:3::10]:42902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dT4Fa-0008FR-KW
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dT4FZ-0008J8-QY
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:43:10 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dT4FZ-0008Ir-Jw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:43:09 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 77so23322870wrb.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:43:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2017 11:42:47 +0100
Message-ID: <CAFEAcA8vvfrzxo_WKEA86nEMaAo2Sgg3B0sSYTTxdkNrdqY35A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/42] Misc changes for 2017-07-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 July 2017 at 08:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 0c7a8b9baa744ae4323bb46cb4fe942355beaa85:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-07-04 11:17:02 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 44eff673411381062b826d048ba9d6630d2b2bdb:
>
>   target/i386: add the CONFIG_TCG into Makefiles (2017-07-05 09:12:44 +0200)
>
> ----------------------------------------------------------------
> * qemu-thread portability improvement (Fam)
> * virtio-scsi IOMMU fix (Jason)
> * poisoning and common-obj-y cleanups (Thomas)
> * initial Hypervisor.framework refactoring (Sergio)
> * x86 TCG interrupt injection fixes (Wu Xiang, me)
> * --disable-tcg support for x86 (Yang Zhong, me)
> * various other bugfixes and cleanups (Daniel, Peter, Thomas)
>

Applied, thanks.

-- PMM
