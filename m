Received: from eggs.gnu.org ([2001:4830:134:3::10]:58125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRki3-000325-6z
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRki1-0001yp-Os
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:06:51 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:34923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRki1-0001yf-Bj
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:06:49 -0500
Received: by mail-vk0-x22c.google.com with SMTP id x75so18878819vke.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:06:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
References: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 19:06:28 +0000
Message-ID: <CAFEAcA_ah6sdu2m1vQDgJgdswo5Tf1tm+sgJGM0vLgUy7RaVvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] tricore-patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 January 2017 at 13:45, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
> The following changes since commit 50788a3fdbade5f8ed1c8296988578133c52c6aa:
>
>   target-tricore: Add updfl instruction (2017-01-11 14:37:37 +0100)
>
> are available in the git repository at:
>
>   https://github.com/bkoppelmann/qemu-tricore-upstream.git tags/pull-tricore-2017-01-11-2
>
> for you to fetch changes up to 50788a3fdbade5f8ed1c8296988578133c52c6aa:
>
>   target-tricore: Add updfl instruction (2017-01-11 14:37:37 +0100)
>
> ----------------------------------------------------------------
> TriCore FPU patches
>
> ----------------------------------------------------------------
>
> Bastian Koppelmann (3):
>   target-tricore: Added FTOUZ instruction
>   target-tricore: Added MADD.F and MSUB.F instructions
>   target-tricore: Add updfl instruction
>
> Peer Adelt (2):
>   target-tricore: Added new MOV instruction variant
>   target-tricore: Added new JNE instruction variant
>
>  target/tricore/fpu_helper.c      | 134 ++++++++++++++++++++++++++++++++++++++-
>  target/tricore/helper.h          |   4 ++
>  target/tricore/translate.c       |  48 ++++++++++++++
>  target/tricore/tricore-opcodes.h |   3 +
>  4 files changed, 188 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
