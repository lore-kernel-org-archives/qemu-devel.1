Received: from eggs.gnu.org ([2001:4830:134:3::10]:39798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWbdZ-00073H-DK
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWbdW-0001kV-5N
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:30:49 -0500
Received: from mail-pl0-x22c.google.com ([2607:f8b0:400e:c01::22c]:44587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWbdV-0001kF-Ve
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:30:46 -0500
Received: by mail-pl0-x22c.google.com with SMTP id n13so610990plp.11
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 21:30:45 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-3-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2f1c184b-f4ba-db66-2918-4e00c3af0a16@linaro.org>
Date: Tue, 2 Jan 2018 21:30:42 -0800
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-3-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 02/21] RISC-V ELF Machine Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/02/2018 04:44 PM, Michael Clark wrote:
> Define RISC-V ELF machine EM_RISCV 243
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  include/elf.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
