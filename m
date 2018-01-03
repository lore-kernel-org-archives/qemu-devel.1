Received: from eggs.gnu.org ([2001:4830:134:3::10]:43384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWpbD-0004dG-EO
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWpb8-00009K-Th
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:25:19 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:45759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWpb8-000083-NJ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:25:14 -0500
Received: by mail-pl0-x241.google.com with SMTP id o2so1887407plk.12
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 12:25:14 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-8-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b18c8dd1-2199-24f8-576e-d7e31304ea1f@linaro.org>
Date: Wed, 3 Jan 2018 12:25:10 -0800
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-8-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/21] RISC-V GDB Stub
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
> GDB Register read and write routines.
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/gdbstub.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 target/riscv/gdbstub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
