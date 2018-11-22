Received: from eggs.gnu.org ([2001:4830:134:3::10]:56907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gPwxz-0001sH-MJ
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 16:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gPwxw-0006RA-Db
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 16:56:55 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:36909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gPwxw-0006OK-7B
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 16:56:52 -0500
Date: Thu, 22 Nov 2018 22:56:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <a7902403-7572-9b64-235e-cb6f9e0efbae@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1811222249030.51852@zero.eik.bme.hu>
References: <87mw8rumhb.fsf@blackfin.pond.sub.org>
	<87y4s8h5rh.fsf@blackfin.pond.sub.org>
	<876132olyi.fsf@blackfin.pond.sub.org>
	<87a8fucx33.fsf@dusky.pond.sub.org>
	<87muq2fgbw.fsf@dusky.pond.sub.org>
	<a7902403-7572-9b64-235e-cb6f9e0efbae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] MAINTAINERS leaves too many files uncovered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 22 Nov 2018, Thomas Huth wrote:
>>      19 hw/display/sm501.c
>
> Maybe Balaton wants to adopt this file?

As discussed before this was originally part of SH4 but since that seems 
to be not actively maintained any more and latest changes were for 
sam460ex I can add it to sam460ex. I planned to do that when I make any 
changes in the future but if needed I can send a patch for this now.

While we're there, should I also add pc-bios/canyonlands.dts which is the 
device tree for sam460ex?

Regards,
BALATON Zoltan
