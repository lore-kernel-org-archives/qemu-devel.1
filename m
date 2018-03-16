Received: from eggs.gnu.org ([2001:4830:134:3::10]:52906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewuDC-0007sV-US
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewuDB-0003mq-RQ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:36:18 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewuDB-0003mL-LD
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:36:17 -0400
Received: by mail-oi0-x242.google.com with SMTP id 20so2322668oiq.5
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:36:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NuGEBy07YVOTzdDNSsoYX6X0+XpMd85YDoVKyQNp=j-PA@mail.gmail.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-20-git-send-email-mjc@sifive.com>
	<f52deedb-6cd7-13b1-082d-ebd6e8ff9290@amsat.org>
	<CAHNT7NvJXQJ8zRYR=p-E99sQmt0v7YtDnoqcgR3t20XkZUqzbg@mail.gmail.com>
	<973a09e1-13a9-ac8a-2601-55aa7c8356bc@ilande.co.uk>
	<4df26b55-cd92-451b-dea9-2ebeb78f46e0@mail.uni-paderborn.de>
	<CAHNT7NuGEBy07YVOTzdDNSsoYX6X0+XpMd85YDoVKyQNp=j-PA@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 11:36:16 -0700
Message-ID: <CAHNT7Nv+dG-RvMSf8t9+e6eyxevHo-E=7U2MZqEVmqq7KMqQfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 19/23] SiFive RISC-V UART Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Stefan O'Rear <sorear2@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>

On Fri, Mar 16, 2018 at 11:30 AM, Michael Clark <mjc@sifive.com> wrote:

>
>
> On Sun, Mar 11, 2018 at 4:43 AM, Bastian Koppelmann <
> kbastian@mail.uni-paderborn.de> wrote:
>
>> Hi Mark,
>>
>> On 03/10/2018 10:40 AM, Mark Cave-Ayland wrote:
>> > On 10/03/18 03:02, Michael Clark wrote:
>> >
>> >> On Sat, Mar 10, 2018 at 1:39 AM, Philippe Mathieu-Daud=C3=A9 <
>> f4bug@amsat.org>
>> >> wrote:
>> >>
>> [...]
>> > Another general note: for each of the main QEMU platforms supported
>> > there is a home page on the official wiki, so do make sure that you se=
t
>> > yourself a template for RiscV and add some information to help people
>> > get started.
>> >
>> Thanks for the pointer. I went ahead and created a basic page for RISC-V
>> with instructions on how to build QEMU and boot Fedora.
>>
>
> Thanks Bastian! I'll add a link back to the official QEMU RISC-V
> Architecture page from the riscv-qemu repo wiki...
>

I noticed there is a spelling mistake in the description: "implented"
instead of "implemented"

Michael.
