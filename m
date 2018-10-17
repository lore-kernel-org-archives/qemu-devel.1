Received: from eggs.gnu.org ([2001:4830:134:3::10]:43682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCahB-0004Q9-65
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCah5-0007dN-Nl
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:32:19 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:37938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCah5-0007cg-05
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:32:15 -0400
Received: by mail-pg1-x536.google.com with SMTP id f8-v6so11695338pgq.5
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 18:32:14 -0700 (PDT)
References: <1539768207-18209-1-git-send-email-peng.hao2@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7847659e-4514-6f4c-a0d7-7434ed486227@linaro.org>
Date: Tue, 16 Oct 2018 18:32:10 -0700
MIME-Version: 1.0
In-Reply-To: <1539768207-18209-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm : add pvpanic mmio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 10/17/18 2:23 AM, Peng Hao wrote:
> +++ b/hw/misc/pvpanic-mmio.c
> @@ -0,0 +1,76 @@
> +#include "qemu/osdep.h"

New file requires file header w/ copyright and license.


r~
