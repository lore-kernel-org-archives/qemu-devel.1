Received: from eggs.gnu.org ([2001:4830:134:3::10]:49271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddcXl-00080c-54
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddbzr-0002WT-5d
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:51:27 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:37019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddbzq-0002TS-Rf
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:46:31 -0400
Received: by mail-wr0-x229.google.com with SMTP id 33so16412962wrz.4
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 05:46:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
References: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2017 13:46:08 +0100
Message-ID: <CAFEAcA-10CwtLRf2hw3b+a3OcQ2-9kS6BT9T8ZNkhC5s9v8Jig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 August 2017 at 15:45, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> The following changes since commit aaaec6acad7cf97372d48c1b09126a09697519c8:
>
>   Update version for v2.10.0-rc1 release (2017-08-02 16:36:32 +0100)
>
> are available in the git repository at:
>
>   git://github.com/yongbok/upstream-qemu.git tags/mips-20170803
>
> for you to fetch changes up to d673a68db6963e86536b125af464bb6ed03eba33:
>
>   target/mips: Fix RDHWR CC with icount (2017-08-02 22:18:13 +0100)
>
> ----------------------------------------------------------------
> MIPS patches 2017-08-03
>
> Changes:
> KVM T&E segment support for TCG
> malta: leave space for the bootmap after the initrd
> Apply CP0.PageMask before writing into TLB entry
> Fix fallout from indirect branch optimisation
>

Applied, thanks.

-- PMM
