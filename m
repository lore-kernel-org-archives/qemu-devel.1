Received: from eggs.gnu.org ([2001:4830:134:3::10]:42288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cXCpL-0006iz-EW
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cXCpH-0001Sk-Ei
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:08:55 -0500
Received: from chuckie.co.uk ([82.165.15.123]:56170
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cXCpH-0001P3-71
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:08:51 -0500
References: <20160912101319.11954.40146.malonedeb@gac.canonical.com>
	<CACXAS8CbChA8EXVwEHCj4d0FvYVOSRrcCz2AoS7Ar9uZ_f-8kA@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a241623e-85b8-98f6-2bf4-aefed4dba32e@ilande.co.uk>
Date: Fri, 27 Jan 2017 20:08:24 +0000
MIME-Version: 1.0
In-Reply-To: <CACXAS8CbChA8EXVwEHCj4d0FvYVOSRrcCz2AoS7Ar9uZ_f-8kA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1622547] Re: [PATCH] target/sparc: Restore
 ldstub of odd asis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1622547 <1622547@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 27/01/17 12:57, Artyom Tarasenko wrote:

> On Fri, Jan 27, 2017 at 9:15 AM, Richard Henderson <rth@twiddle.net> wrote:
>> Fixes the booting of ss20 roms.
> 
> Mike, can you please test this fix?
> 
>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Initially Reported-by: Michael Russo <mike@papersolve.com>
> 
>> Signed-off-by: Richard Henderson <rth@twiddle.net>

Thanks Richard.

I've given this a quick spin around my various SPARC images and it looks
good with no regressions, so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Also when resubmitting with the updated Reported-by above, can we also
CC qemu-stable to get this into the next 2.8 release?


ATB,

Mark.
