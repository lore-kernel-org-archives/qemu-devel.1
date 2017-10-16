Received: from eggs.gnu.org ([2001:4830:134:3::10]:49961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e41bY-0007NJ-CI
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e41bX-0007Tf-JI
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:22:36 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:46591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e41bX-0007Q4-Ak
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:22:35 -0400
Received: by mail-wm0-x232.google.com with SMTP id m72so1049173wmc.1
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 02:22:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2017 10:22:12 +0100
Message-ID: <CAFEAcA-g7aGDCnQdspj=k+G4LTxe2BPNN_pfM_HVgTcz9WVgWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 12 October 2017 at 17:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> target-arm queue:
>  * mostly my latest v8M stuff, plus a couple of minor patches
>
> The following changes since commit a0b261db8c030813e30a39eae47359ac2a37f7e2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2017-10-12 10:02:09 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171012
>
> for you to fetch changes up to cf5f7937b05c84d5565134f058c00cd48304a117:
>
>   nvic: Fix miscalculation of offsets into ITNS array (2017-10-12 16:33:16 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * v8M: SG, BLXNS, secure-return
>  * v8M: fixes for coverity issues in previous patches
>  * arm: fix armv7m_init() declaration to match definition
>  * watchdog/aspeed: fix variable type to store reload value
>

Applied, thanks.

-- PMM
