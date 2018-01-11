Received: from eggs.gnu.org ([2001:4830:134:3::10]:34308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZepS-0002jF-81
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZepP-0005al-58
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:31:42 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:46965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZepO-0005Zm-VZ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:31:39 -0500
Received: by mail-pf0-x242.google.com with SMTP id y5so1894794pff.13
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 07:31:38 -0800 (PST)
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-8-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fdbbe8f0-af61-46c5-0b54-fd6896dd21c0@linaro.org>
Date: Thu, 11 Jan 2018 07:31:35 -0800
MIME-Version: 1.0
In-Reply-To: <1515637324-96034-8-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/21] RISC-V GDB Stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 01/10/2018 06:21 PM, Michael Clark wrote:
> GDB Register read and write routines.
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/gdbstub.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 target/riscv/gdbstub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
