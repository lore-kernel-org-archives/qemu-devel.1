Received: from eggs.gnu.org ([2001:4830:134:3::10]:40086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euL7c-0004zm-UK
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euL7c-0001yS-4l
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:43:56 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:34257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euL7c-0001yB-09
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:43:56 -0500
Received: by mail-oi0-x236.google.com with SMTP id c83so7439888oib.1
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 08:43:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305084111.GM2450@redhat.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<20180305084111.GM2450@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 16:43:34 +0000
Message-ID: <CAFEAcA8=fizLvBxVCby4jsGGK8RyXQs0FmeXxA=ZWXT+er-4ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 5 March 2018 at 08:41, Richard W.M. Jones <rjones@redhat.com> wrote:
>
> The attached patch is also needed to avoid crashes during various
> math-heavy test suites.

Applied to master, thanks.

FYI, sending patches as attachments in the middle of a long
thread on something else is a good way to cause them to get
lost. Luckily Michael ran into the same bug again and that
reminded me to fish this one out.

thanks
-- PMM
