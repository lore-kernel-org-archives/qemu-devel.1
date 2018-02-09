Received: from eggs.gnu.org ([2001:4830:134:3::10]:53886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekEUw-0001q8-3T
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekEUt-0001cT-0o
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:38:14 -0500
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:35570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekEUs-0001bJ-R8
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:38:10 -0500
Received: by mail-io0-x230.google.com with SMTP id m11so10835292iob.2
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 11:38:10 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-13-git-send-email-mjc@sifive.com>
	<82554ae4-5348-f30b-3b77-64754046198b@linaro.org>
	<CAHNT7NsYT_bPpiOx2oUqsYCCAU1TOhx3ytAoU-a6pTbkkA_pnA@mail.gmail.com>
	<CAHNT7NubFsYQ+0A=iURqTbQDpA=L+mgr7P+qDzZEyXacJcfyig@mail.gmail.com>
	<CAHNT7Nsw9-7G34fuUW1aBeiR_ouh1sZJdWYiw1w1ws6M0CY5Zg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <22c65f8e-ca99-8da7-c6df-c16212ad36ab@linaro.org>
Date: Fri, 9 Feb 2018 11:38:06 -0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nsw9-7G34fuUW1aBeiR_ouh1sZJdWYiw1w1ws6M0CY5Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 12/23] RISC-V HTIF Console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/09/2018 01:08 AM, Michael Clark wrote:
> https://github.com/michaeljclark/riscv-qemu/commit/17272f5c66adf8532f196d660d2a593c2178ac95
> 
>  hw/core/loader.c     |   18 ++++++++++++++++--
>  include/hw/elf_ops.h |   28 ++++++++++++++++------------
>  include/hw/loader.h  |   17 ++++++++++++++++-
>  3 files changed, 48 insertions(+), 15 deletions(-)


Much better, thanks.  Please fix the formatting though
(braces around if blocks).


r~
