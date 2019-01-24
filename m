Received: from eggs.gnu.org ([209.51.188.92]:60776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmibq-0000YT-JE
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmibp-0003rv-Rj
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:16:10 -0500
References: <20181102152257.20637-1-mark.cave-ayland@ilande.co.uk>
	<e18d32e6-4c6f-1d42-7e90-ef9d84721524@tuxfamily.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3d217d08-56c9-4bab-f897-9ebe67910168@vivier.eu>
Date: Thu, 24 Jan 2019 18:15:48 +0100
MIME-Version: 1.0
In-Reply-To: <e18d32e6-4c6f-1d42-7e90-ef9d84721524@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/10] hw/m68k: add Apple Machintosh
 Quadra 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net

On 24/01/2019 18:02, Thomas Huth wrote:
> On 2018-11-02 16:22, Mark Cave-Ayland wrote:
>> (MCA: here's the latest version of the q800 patchset. I've hope that I've
>> addressed most of the comments, plus this will now boot into the Debian
>> installer correctly when applied to git master.
> 
> Any update on this series? Why did it get stalled again?
> 

I was thinking about this today.

Mark, perhaps you can send a rebased version of the series?

I think we need reviews for "esp: add pseudo-DMA as used by Macintosh".

Thanks,
Laurent
