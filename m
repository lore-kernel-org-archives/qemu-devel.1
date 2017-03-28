Received: from eggs.gnu.org ([2001:4830:134:3::10]:37842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csmnr-00065L-Rq
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csmnr-0005az-3s
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:48:35 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:32932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csmnq-0005al-Tq
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:48:35 -0400
Received: by mail-wr0-x22c.google.com with SMTP id w43so79985675wrb.0
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 01:48:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170327161615.19637-1-pbonzini@redhat.com>
References: <20170327161615.19637-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 09:48:13 +0100
Message-ID: <CAFEAcA8-oEzrjj+GgzvVK+hwfk83oejbf1ONGd7ioFN6RWtWFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/9] Misc fixes for QEMU 2.9.0-rc2
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

On 27 March 2017 at 17:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 08329701199449bde497570dcfdb9c86062baf20:
>
>   qom: Fix regression with 'qom-type' (2017-03-23 17:59:40 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to bed58b4443b001227b953dca80ce76fa76ea0fc1:
>
>   scsi-generic: Fill in opt_xfer_len in INQUIRY reply if it is zero (2017-03-27 17:02:07 +0200)
>
> ----------------------------------------------------------------
> * MTTCG fix for win32
> * virtio-scsi assertion failure
> * mem-prealloc coverity fix
> * x86 migration revert which requires more thought
> * x86 instruction limit (avoids >2 page translation blocks)
> * nbd dead code cleanup
> * small memory.c logic fix
>

Applied, thanks.

-- PMM
