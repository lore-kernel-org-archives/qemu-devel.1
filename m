Received: from eggs.gnu.org ([2001:4830:134:3::10]:36573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emJ9n-0006Y4-Vx
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emJ9g-0000OB-F0
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:01:00 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emJ9g-0000Nf-9B
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:00:52 -0500
Received: by mail-oi0-x242.google.com with SMTP id 8so18966734oix.7
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:00:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180214103906.3704-1-laurent@vivier.eu>
References: <20180214103906.3704-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:00:30 +0000
Message-ID: <CAFEAcA8iUpuW_xHF4qWD46gE4r5FPT00GN89wagr38azZgyv=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 February 2018 at 10:39, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit bec9c64ef7be8063f1192608b83877bc5c9ea217:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-02-13 18:24:08 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request
>
> for you to fetch changes up to 1226e212292e271b8795265c9639d5c0553df199:
>
>   m68k: implement movep instruction (2018-02-14 11:09:13 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Pavel Dovgalyuk (1):
>   m68k: implement movep instruction
>
>  target/m68k/cpu.c       |  2 ++
>  target/m68k/cpu.h       |  1 +
>  target/m68k/translate.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)

Applied, thanks.

-- PMM
