Received: from eggs.gnu.org ([209.51.188.92]:44229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guI6E-00005M-9N
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guI62-0003P5-8n
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:34:42 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:41060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guI5v-0003HZ-AO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:34:35 -0500
Received: by mail-ot1-x331.google.com with SMTP id u16so10764133otk.8
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 06:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20190213154450.14749-1-palmer@sifive.com>
In-Reply-To: <20190213154450.14749-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 14:34:15 +0000
Message-ID: <CAFEAcA97_O8zvuY8JQ8vOgcSs9Di=f_JU7YacDb2=TfOZNOjUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for the 4.0 Soft Freeze,
 Part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 13 Feb 2019 at 15:45, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> merged tag 'pull-tcg-20190211'
> Primary key fingerprint: 7A48 1E78 868B 4DB6 A85A  05C0 64DF 38E8 AF7E 215F
> The following changes since commit 22c5f446514a2a4bb0dbe1fea26713da92fc85fa:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190211' into staging (2019-02-11 17:04:57 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.0-sf1
>
> for you to fetch changes up to 40e46e516d90c2dfe8e8de3741c1c65f1b526502:
>
>   riscv: Ensure the kernel start address is correctly cast (2019-02-11 15:56:22 -0800)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
