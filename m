Received: from eggs.gnu.org ([2001:4830:134:3::10]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cX3f9-0002wd-1h
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cX3f8-00059C-8B
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:21:47 -0500
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-2-git-send-email-armbru@redhat.com>
	<04ee1f95-988e-02f7-c1a9-f9630daf54da@redhat.com>
	<87sho59elv.fsf@dusky.pond.sub.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <e84e419d-f6c4-d87b-54b5-748f34f702b6@imgtec.com>
Date: Fri, 27 Jan 2017 10:21:28 +0000
MIME-Version: 1.0
In-Reply-To: <87sho59elv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/8] hw: Default -drive to if=ide
 explicitly where it works
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>


>> Slightly off-topic, but: Is fulong2e still maintained? I did not spot an
>> entry in MAINTAINERS...?
> 
> It's covered by the general MIPS stanza:
> 
>     $ scripts/get_maintainer.pl -f hw/mips/mips_fulong2e.c 
>     Aurelien Jarno <aurelien@aurel32.net> (maintainer:MIPS)
>     Yongbok Kim <yongbok.kim@imgtec.com> (maintainer:MIPS)
>     qemu-devel@nongnu.org (open list:All patches CC here)
> 

I'm not actively looking after the device at the moment but if it has any
issues I love to handle that.

Regards,
Yongbok
