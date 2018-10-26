Received: from eggs.gnu.org ([2001:4830:134:3::10]:58283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG9Z7-0001Ca-SN
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 17:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG9Z6-0007gq-6F
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 17:22:45 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:36293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gG9Z6-0007gj-0Z
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 17:22:44 -0400
Received: by mail-oi1-x233.google.com with SMTP id r127-v6so519423oie.3
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 14:22:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1540498768-8736-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540498768-8736-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Oct 2018 22:22:22 +0100
Message-ID: <CAFEAcA8O1uMw1OJ-E_Nm7NtzOfqLT-dOTKqY+7z=3s0QRgLHOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] MIPS queue for October 2018 - part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 25 October 2018 at 21:19, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 808ebd66e467f77c0d1f8c6346235f81e9c99cf2:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-for-master-3.1-sf0' into staging (2018-10-25 17:41:03 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-oct-2018-part-3
>
> for you to fetch changes up to 89a955e8df3dba6f96859cd0339356243b6c996f:
>
>   target/mips: Add disassembler support for nanoMIPS (2018-10-25 22:13:33 +0200)
>
> ----------------------------------------------------------------
> MIPS queue for October 2018 - part 3
>
>   - this pull request contains three assorted nanoMIPS issues
>   - three checkpatch.pl warnings are known and should be ignored
> ----------------------------------------------------------------
>


Applied, thanks.

-- PMM
