Received: from eggs.gnu.org ([2001:4830:134:3::10]:49230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHB16-0005H1-Nn
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHB13-0007UW-IC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:07:52 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHB13-0007Rw-6B
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:07:49 -0400
Received: by mail-pl1-x644.google.com with SMTP id bb7-v6so4103998plb.13
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 10:07:47 -0700 (PDT)
Date: Mon, 29 Oct 2018 10:07:45 -0700 (PDT)
In-Reply-To: <9cf83a16-250c-ff01-0783-74d5b2077999@redhat.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-c52bc62b-cbc8-4281-98f2-6962c283fd59@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Add Alistair as a RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

On Mon, 29 Oct 2018 09:30:54 PDT (-0700), philmd@redhat.com wrote:
> On 29/10/18 17:16, Palmer Dabbelt wrote:
>> Alistair has been contributing to the RISC-V QEMU port for a while now
>> so I'd like him to be officially listed as a maintainer.  I've checked
>> with the other RISC-V mainatiners and there are no objectics, and I've
>
> "maintainers" "objections"

Ah, thanks -- I guess the first email I write it the morning shouldn't go out 
in public :).

>
>> also checked with Alistair so he knows I'm volunteering him.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> FWIW:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d794bd7a66fe..d550fd8b809c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -241,6 +241,7 @@ F: disas/ppc.c
>>   RISC-V
>>   M: Michael Clark <mjc@sifive.com>
>>   M: Palmer Dabbelt <palmer@sifive.com>
>> +M: Alistair Francis <Alistair.Francis@wdc.com>
>>   M: Sagar Karandikar <sagark@eecs.berkeley.edu>
>>   M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>>   S: Maintained
>>
