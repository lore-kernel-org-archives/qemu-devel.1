Received: from eggs.gnu.org ([2001:4830:134:3::10]:44276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gFmLg-0001PO-HR
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gFmG6-0006Yt-30
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:29:35 -0400
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-6-mark.cave-ayland@ilande.co.uk>
	<19364d5d-005b-eae5-b61c-e16b211667ea@posteo.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <648293b0-3ad1-45fc-bb57-c51e11b5cb51@ilande.co.uk>
Date: Thu, 25 Oct 2018 21:29:01 +0100
MIME-Version: 1.0
In-Reply-To: <19364d5d-005b-eae5-b61c-e16b211667ea@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/11] hw/m68k: Apple Sound Chip (ASC)
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <th.huth@posteo.de>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, yongbok.kim@mips.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

On 23/10/2018 08:18, Thomas Huth wrote:

> On 2018-10-18 19:28, Mark Cave-Ayland wrote:
>> From: Laurent Vivier <laurent@vivier.eu>
>>
>> This is broken as the linux driver seems broken too...
> 
> So is this required for the initial version, or does Linux also boot
> without this device in the emulated machine? In the first case, please
> mention it in the cover letter. In the latter case, maybe skip the patch
> for now and add it later instead, once this has been fixed...?

Hmmm I'm not sure whether or not having this device missing is enough to break Linux
boot? Laurent?


ATB,

Mark.
