Received: from eggs.gnu.org ([2001:4830:134:3::10]:58939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHsjT-0001Eg-SB
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHsjR-0001XF-E0
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:48:35 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHsjP-0001EF-CV
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:48:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id m9-v6so4861057pgl.13
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 08:48:20 -0700 (PDT)
Date: Wed, 31 Oct 2018 08:48:17 -0700 (PDT)
In-Reply-To: <CAKmqyKP8sic_SEiqugH2=119GcyZQthv=QVds0c00J0W5uXc2A@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-6c6dfbeb-7205-45c2-a533-15badb047dd1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 2/3] Add Alistair as a RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Tue, 30 Oct 2018 14:33:23 PDT (-0700), alistair23@gmail.com wrote:
> On Tue, Oct 30, 2018 at 2:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> Alistair has been contributing to the RISC-V QEMU port for a while now
>> so I'd like him to be officially listed as a maintainer.  I've checked
>> with the other RISC-V maintainers and there are no objections, and I've
>> also checked with Alistair so he knows I'm volunteering him.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> Hey Palmer,
>
> It looks like you dropped a Reviewed by here. It's not super important
> in this case but for future patches it could be an issue.
>
> If you use QEMU's patches it should apply the tags for you:
> https://github.com/stefanha/patches

Sorry about that.  I'll take a look at patches.

>
> Alistair
>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d794bd7a66fe..d550fd8b809c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -241,6 +241,7 @@ F: disas/ppc.c
>>  RISC-V
>>  M: Michael Clark <mjc@sifive.com>
>>  M: Palmer Dabbelt <palmer@sifive.com>
>> +M: Alistair Francis <Alistair.Francis@wdc.com>
>>  M: Sagar Karandikar <sagark@eecs.berkeley.edu>
>>  M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>>  S: Maintained
>> --
>> 2.18.1
>>
>>
