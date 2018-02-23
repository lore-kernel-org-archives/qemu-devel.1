Received: from eggs.gnu.org ([2001:4830:134:3::10]:55657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKw1-0002zz-5f
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKvx-00056U-97
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:31:17 -0500
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:35322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epKvx-00052P-2m
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:31:13 -0500
Received: by mail-pf0-x229.google.com with SMTP id y186so3347408pfb.2
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 13:31:12 -0800 (PST)
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dc9974bc-0428-1a20-52c1-0aa46c7eebf9@linaro.org>
Date: Fri, 23 Feb 2018 13:31:09 -0800
MIME-Version: 1.0
In-Reply-To: <1519344729-73482-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>, Peter Maydell <peter.maydell@linaro.org>

On 02/22/2018 04:11 PM, Michael Clark wrote:
> QEMU RISC-V Emulation Support (RV64GC, RV32GC)
> 
> This is hopefully the "fix remaining issues in-tree" release.

FWIW, I'm happy with this.

For those patches that I haven't given an explicit R-b, e.g. most of hw/, I
didn't see anything obviously wrong.  So I'll give them

Acked-by: Richard Henderson <richard.henderson@linaro.org>

Unless anyone has any other comments, I would expect the next step would be for
you to create a signed pull request for Peter.


r~
