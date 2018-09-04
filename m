Received: from eggs.gnu.org ([2001:4830:134:3::10]:48619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxHmw-00050a-6W
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxHmv-00027D-2n
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:19:02 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fxHmu-00025R-PU
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:19:01 -0400
Received: by mail-lj1-x243.google.com with SMTP id j19-v6so4268417ljc.7
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 13:19:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180831222249.GA28489@flamenco>
References: <20180810173941.5301-1-cota@braap.org>
	<20180831222249.GA28489@flamenco>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Sep 2018 13:18:28 -0700
Message-ID: <CAKmqyKO2jK0YnJepSazMeCtMtFLpEMaY6UOeyHbGWKED0Z=CJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/riscv: use
 tcg_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>

On Fri, Aug 31, 2018 at 3:22 PM, Emilio G. Cota <cota@braap.org> wrote:
> On Fri, Aug 10, 2018 at 13:39:38 -0400, Emilio G. Cota wrote:
>> Changes wrt v1: changed patch 3 as suggested by Richard. Also
>> added his R-b's.
>>
>> You can fetch this series from:
>>   https://github.com/cota/qemu/tree/riscv-lookup_ptr-v2
>
> RISC-V maintainers: any plans of picking this up for 3.1?

Thanks for CCing me.

I think Michael must be really busy, I haven't seen any activity for
awhile. I'm going to send a PR with everything that has been reviewed
and applies cleanly.

Alistair

>
> (Cc'ing Alistair since he recently submitted some riscv-related
> pull requests; BTW Alistair, should you be listed as a RISC-V
> maintainer?)
>
> Thanks,
>
>                 Emilio
>
