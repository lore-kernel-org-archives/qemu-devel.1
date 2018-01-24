Received: from eggs.gnu.org ([2001:4830:134:3::10]:37219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeRUm-0006BW-MD
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeRUk-0007Y4-Mq
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:18:07 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:33951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eeRUk-0007Xv-Ht
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:18:06 -0500
Received: by mail-oi0-x22a.google.com with SMTP id k15so3718705oib.1
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 12:18:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516651649-28514-1-git-send-email-jcmvbkbc@gmail.com>
References: <1516651649-28514-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Jan 2018 20:17:45 +0000
Message-ID: <CAFEAcA-AawaXs7s2o17O6wNRRp=bpfBvLZkB3kAYdcB0UDhigQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/10] target/xtensa updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 January 2018 at 20:07, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following batch of updates for the target/xtensa.
>
> Changes v1->v2:
> - use fsf core for both MMU and noMMU in qemu-system-xtensaeb.
>
> The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9ff:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180111' into staging (2018-01-11 14:34:41 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20180122-xtensa
>
> for you to fetch changes up to 847a6473206607bc6c84f6c537a0fe603ff7aaa6:
>
>   target/xtensa: disas/xtensa: fix coverity warnings (2018-01-22 11:54:58 -0800)
>
> ----------------------------------------------------------------
> target/xtensa updates:
>
> - make mini-bootloader independent of the initial CPU state;
> - add noMMU XTFPGA variants;
> - add two noMMU cores: de212 and sample_controller;
> - fix issues reported by coverity against xtensa translator and disassembler.

Applied, thanks.

-- PMM
