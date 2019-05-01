Received: from eggs.gnu.org ([209.51.188.92]:54726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLddF-0003G4-CU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLddC-0007hk-AT
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:01:57 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hLddC-0007gs-30
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:01:54 -0400
Received: by mail-pg1-x542.google.com with SMTP id j26so7653118pgl.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 18:01:53 -0700 (PDT)
Date: Tue, 30 Apr 2019 18:01:51 -0700 (PDT)
In-Reply-To: <9384b35d-41d0-65b0-17ca-7291c530d13f@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-a33acc90-e882-4238-975c-c5611090fafc@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/8] target/riscv: decodetree
 improvments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On Thu, 25 Apr 2019 09:23:56 PDT (-0700), richard.henderson@linaro.org wrote:
> On 4/25/19 9:04 AM, Palmer Dabbelt wrote:
>>
>> Thanks!  I'm happy taking this as it stands, since all those decode issues I
>> pointed out aren't regressions in this patch set.  Let me know if you want to
>> fix those or if you want me to -- as you can probably tell my email queue is a
>> bit long... :)
>
> I'm happy to fix those, if you'll point me at your branch.

github.com/palmer-dabbelt/riscv-qemu, for-master branch.  I haven't sent the PR
because I haven't banged on the branch yet, but I don't anticipate any major
problems.
