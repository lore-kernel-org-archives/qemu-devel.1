Received: from eggs.gnu.org ([2001:4830:134:3::10]:42541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFFns-0003OD-P2
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFFnn-00038C-MD
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:50:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gFFnn-00037J-4r
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:50:11 -0400
Received: by mail-wm1-x342.google.com with SMTP id y144-v6so4674629wmd.4
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 02:50:10 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-8-richard.henderson@linaro.org>
	<5bb7fe79-a2a0-7a01-beb8-c23c3a2d2d5f@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c54b4662-3627-8998-a4af-fc654b01ac37@linaro.org>
Date: Wed, 24 Oct 2018 10:49:49 +0100
MIME-Version: 1.0
In-Reply-To: <5bb7fe79-a2a0-7a01-beb8-c23c3a2d2d5f@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] target/riscv: Splice decodetree inputs
 for riscv32 vs riscv64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

On 10/24/18 10:33 AM, Bastian Koppelmann wrote:
> On 10/23/18 2:04 PM, Richard Henderson wrote:
> Either this or one of the last two patches breaks booting fedora. I couldn't
> figure the problem out just yet.

I didn't do any testing on it, and may well have messed something up in the
process.  (I have not yet downloaded any images with which to do such testing
either.)

My main purpose was as proof of concept, in that the process can be set up in a
way that has some advantages.  I was assuming already that you'd go back and
work in some adjustments into your original patches, not that you'd take mine
as-is.


r~
