Received: from eggs.gnu.org ([209.51.188.92]:58725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grnzZ-0005Mf-VI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grnzM-0003yO-Nv
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:01:34 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grnzE-0003s7-Ts
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:01:23 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so1396149otl.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20190205135129.19338-1-aaron@os.amperecomputing.com>
In-Reply-To: <20190205135129.19338-1-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 18:01:07 +0000
Message-ID: <CAFEAcA_rZc6PHrUrJwn=wPFX95aF1CMKa5vKRg1bQ4E1f3uZ1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Fix CRn to be 14 for
 PMEVTYPER/PMEVCNTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, 5 Feb 2019 at 13:51, Aaron Lindsay OS
<aaron@os.amperecomputing.com> wrote:
>
> This bug was introduced in:
>     commit 5ecdd3e47cadae83a62dc92b472f1fe163b56f59
>     target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>




Applied to target-arm.next, thanks.

-- PMM
