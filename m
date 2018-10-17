Received: from eggs.gnu.org ([2001:4830:134:3::10]:37666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gCsu8-0000LT-Ez
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 16:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gCsu4-0002fc-F9
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 16:58:56 -0400
Received: from chuckie.co.uk ([82.165.15.123]:57165
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gCsu2-0002cw-NS
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 16:58:50 -0400
References: <20180727123112.13707-1-dgilbert@redhat.com>
	<d09b7607-a23b-7c05-9faf-7ec0000684af@ilande.co.uk>
	<20180727134453.GB2498@work-vm>
	<c8608e2e-35da-d095-193a-626d0d47c036@ilande.co.uk>
	<20180727151412.GC2498@work-vm> <20181016113044.GE2426@work-vm>
	<20181017003415.GK16167@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3bc604c6-7d8c-9c0e-6471-e9ca1fa13334@ilande.co.uk>
Date: Wed, 17 Oct 2018 21:58:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181017003415.GK16167@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] macio/pmu: Fix missing vmsd terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, agraf@suse.de

On 17/10/2018 01:34, David Gibson wrote:

> On Tue, Oct 16, 2018 at 12:30:45PM +0100, Dr. David Alan Gilbert wrote:
>>
>> I noticed this hadn't got merged - who wants it?
> 
> I think that's one for my tree, but I'm afraid I completely missed it
> before.  It's generally best to CC me on ppc related patches,
> otherwise I'm likely to lose them in the flood of qemu-devel.
> 
> Anyway, I dug it out of my archives and applied.

Great - thanks David. Apologies for the delay in my response, I've been fairly flat
out recently so not much time for QEMU hacking.


ATB,

Mark.
