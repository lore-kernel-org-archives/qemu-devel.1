Received: from eggs.gnu.org ([2001:4830:134:3::10]:45260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXPwA-0003w9-Jp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXPwA-000136-0x
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:41:06 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXPw9-00012j-O5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:41:05 -0400
Received: by mail-wr0-x22b.google.com with SMTP id w4so22673284wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:41:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 11:40:43 +0100
Message-ID: <CAFEAcA9cdrM-2QpEsMXQzEm5Q=0ay5bqR4M1HtGh3eG=-fUi_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 13:44, Peter Maydell <peter.maydell@linaro.org> wrote:
> ARM queue for 2.10 soft freeze...
>
> thanks
> -- PMM
>
> The following changes since commit 6632f6ff96f0537fc34cdc00c760656fc62e23c5:
>
>   Merge remote-tracking branch 'remotes/famz/tags/block-and-testing-pull-request' into staging (2017-07-17 11:46:36 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170717
>
> for you to fetch changes up to e5a6a6e64e82a132cebef023d867085b0a2993d7:
>
>   MAINTAINERS: Add entries for MPS2 board (2017-07-17 13:36:09 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * new model of the ARM MPS2/MPS2+ FPGA based development board
>  * clean up DISAS_* exit conditions and fix various regressions
>    since commits e75449a346 8a6b28c7b5 (in particular including
>    ones which broke OP-TEE guests)
>  * make Cortex-M3 and M4 correctly default to 8 PMSA regions
>

Applied, thanks.

-- PMM
