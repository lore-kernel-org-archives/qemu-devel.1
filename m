Received: from eggs.gnu.org ([2001:4830:134:3::10]:55276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1ewwFN-0001gX-9b
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1ewwFK-0001at-6r
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:46:41 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:55918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1ewwFJ-0001Yp-SP
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:46:38 -0400
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-20-git-send-email-mjc@sifive.com>
	<f52deedb-6cd7-13b1-082d-ebd6e8ff9290@amsat.org>
	<CAHNT7NvJXQJ8zRYR=p-E99sQmt0v7YtDnoqcgR3t20XkZUqzbg@mail.gmail.com>
	<973a09e1-13a9-ac8a-2601-55aa7c8356bc@ilande.co.uk>
	<4df26b55-cd92-451b-dea9-2ebeb78f46e0@mail.uni-paderborn.de>
	<CAHNT7NuGEBy07YVOTzdDNSsoYX6X0+XpMd85YDoVKyQNp=j-PA@mail.gmail.com>
	<CAHNT7Nv+dG-RvMSf8t9+e6eyxevHo-E=7U2MZqEVmqq7KMqQfQ@mail.gmail.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <e06bd3dd-d8fd-4ae2-42dc-ec99a17f2139@mail.uni-paderborn.de>
Date: Fri, 16 Mar 2018 21:46:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nv+dG-RvMSf8t9+e6eyxevHo-E=7U2MZqEVmqq7KMqQfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 19/23] SiFive RISC-V UART Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan O'Rear <sorear2@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>

On 03/16/2018 07:36 PM, Michael Clark wrote:
> On Fri, Mar 16, 2018 at 11:30 AM, Michael Clark <mjc@sifive.com> wrote:
> 
>>
>>
>> On Sun, Mar 11, 2018 at 4:43 AM, Bastian Koppelmann <
>> kbastian@mail.uni-paderborn.de> wrote:
>>
>>> Hi Mark,
>>>
>>> On 03/10/2018 10:40 AM, Mark Cave-Ayland wrote:
>>>> On 10/03/18 03:02, Michael Clark wrote:
>>>>
>>>>> On Sat, Mar 10, 2018 at 1:39 AM, Philippe Mathieu-Daudé <
>>> f4bug@amsat.org>
>>>>> wrote:
>>>>>
>>> [...]
>>>> Another general note: for each of the main QEMU platforms supported
>>>> there is a home page on the official wiki, so do make sure that you set
>>>> yourself a template for RiscV and add some information to help people
>>>> get started.
>>>>
>>> Thanks for the pointer. I went ahead and created a basic page for RISC-V
>>> with instructions on how to build QEMU and boot Fedora.
>>>
>>
>> Thanks Bastian! I'll add a link back to the official QEMU RISC-V
>> Architecture page from the riscv-qemu repo wiki...
>>
> 
> I noticed there is a spelling mistake in the description: "implented"
> instead of "implemented"

Woops, fixed :).

Cheers,
Bastian
