Received: from eggs.gnu.org ([2001:4830:134:3::10]:54411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1euzNq-0001SD-OQ
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 07:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1euzNn-0001rs-MJ
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 07:43:22 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:34872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1euzNn-0001q6-Ba
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 07:43:19 -0400
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-20-git-send-email-mjc@sifive.com>
	<f52deedb-6cd7-13b1-082d-ebd6e8ff9290@amsat.org>
	<CAHNT7NvJXQJ8zRYR=p-E99sQmt0v7YtDnoqcgR3t20XkZUqzbg@mail.gmail.com>
	<973a09e1-13a9-ac8a-2601-55aa7c8356bc@ilande.co.uk>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <4df26b55-cd92-451b-dea9-2ebeb78f46e0@mail.uni-paderborn.de>
Date: Sun, 11 Mar 2018 12:43:07 +0100
MIME-Version: 1.0
In-Reply-To: <973a09e1-13a9-ac8a-2601-55aa7c8356bc@ilande.co.uk>
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Stefan O'Rear <sorear2@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>

Hi Mark,

On 03/10/2018 10:40 AM, Mark Cave-Ayland wrote:
> On 10/03/18 03:02, Michael Clark wrote:
> 
>> On Sat, Mar 10, 2018 at 1:39 AM, Philippe Mathieu-Daudé <f4bug@amsat.org>
>> wrote:
>>
[...]
> Another general note: for each of the main QEMU platforms supported
> there is a home page on the official wiki, so do make sure that you set
> yourself a template for RiscV and add some information to help people
> get started.
>
Thanks for the pointer. I went ahead and created a basic page for RISC-V
with instructions on how to build QEMU and boot Fedora.

Cheers,
Bastian
