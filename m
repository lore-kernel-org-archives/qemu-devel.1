Received: from eggs.gnu.org ([2001:4830:134:3::10]:47919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fZE47-0004QB-1Q
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 07:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fZE43-0004on-Up
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 07:29:19 -0400
Date: Sat, 30 Jun 2018 13:29:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180630061443.GP3422@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806301325320.13465@zero.eik.bme.hu>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<607559ef0fd95f557b5001a5db29883f@sebastianbauer.info>
	<20180630061443.GP3422@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, qemu-ppc@nongnu.org

On Sat, 30 Jun 2018, David Gibson wrote:
> On Fri, Jun 29, 2018 at 08:06:10PM +0200, Sebastian Bauer wrote:
>> Hi,
>>
>> Am 2018-06-19 06:36, schrieb David Gibson:
>>> Ok.  However, your patch doesn't apply against the ppc-for-3.0 tree.
>>> It looks like you've made it against a tree including some of BALATON
>>> Zoltan's proposed but not yet merged patches.
>>>
>>> Please make sure your patches are against the current ppc-for-3.0 tree
>>> before posting.
>>
>> The patch seems to apply now to ppc-for-3.0 without any problem as Zoltan's
>> changes have been integrated. Let me know if I shall resend the patch or if
>> you can use the original one. Thanks.
>
> Resend please.  Assuming it would need a respin, I didn't keep it
> around.

Still avalilable here:

http://patchwork.ozlabs.org/patch/931209/

or here

http://patchew.org/QEMU/20180618215601.8974-1-mail@sebastianbauer.info/

Regards,
BALATON Zoltan
