Received: from eggs.gnu.org ([2001:4830:134:3::10]:41505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fRg7G-0003nk-3y
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fRg7F-00085D-8p
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:49:22 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20180608200558.386-1-laurent@vivier.eu>
	<20180608200558.386-2-laurent@vivier.eu>
	<ee96b76a-6ad2-0784-4981-f4dc3bc03c47@ilande.co.uk>
Message-ID: <16bdfd62-f7f1-82d3-ad7b-b293724d30b2@ilande.co.uk>
Date: Sat, 9 Jun 2018 16:48:45 +0100
MIME-Version: 1.0
In-Reply-To: <ee96b76a-6ad2-0784-4981-f4dc3bc03c47@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 01/13] hw/m68k: add via support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 09/06/18 11:01, Mark Cave-Ayland wrote:

> Yeah, we can certainly remove a huge chunk of this by converting over to 
> the mos6522 device. My last set of updates to CUDA a couple of days ago 
> are probably the best reference, but I can probably find some time to do 
> the basic conversion for you at some point...

BTW is there a particular github branch I should be working from in 
order to attempt this?


ATB,

Mark.
