Received: from eggs.gnu.org ([2001:4830:134:3::10]:43982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dB6VP-0003Bf-1L
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dB6VL-00008v-T0
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:29:15 -0400
Received: from sonic305-48.consmr.mail.ir2.yahoo.com ([77.238.177.110]:39705)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie1@yahoo.com>) id 1dB6VL-00008m-JX
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:29:11 -0400
Date: Wed, 17 May 2017 21:25:09 +0000 (UTC)
From: John Bradley <flypie1@yahoo.com>
Reply-To: John Bradley <flypie1@yahoo.com>
Message-ID: <968647832.156883.1495056309814@mail.yahoo.com>
In-Reply-To: <bcff9cd4-3ec2-0757-02e0-96f0e0a7747e@redhat.com>
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
	<684185116.2952708.1495044580181@mail.yahoo.com>
	<3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
	<107015620.2969780.1495046091978@mail.yahoo.com>
	<5a2b9e50-1444-af4a-dc89-021a4beca0f4@redhat.com>
	<1832071588.99743.1495054408073@mail.yahoo.com>
	<bcff9cd4-3ec2-0757-02e0-96f0e0a7747e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom
 Perhiperals for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Geert Martin Ijewski <gm.ijewski@web.de>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Well unfortunately Eric. I don't understand your "top posted" slang.

As for his "intent", it is quite irrelevant as I have gone over the code line by line and what every he intended to do, he has succeed, as far as I can tell , in matching you standards, to such an extent that I am happy that 


 
John Bradley
Tel: 07896 839635
Skype: flypie125
125B Grove Street
Edge Hill 
Liverpool L7 7AF


On Wednesday, 17 May 2017, 22:15, Eric Blake <eblake@redhat.com> wrote:



On 05/17/2017 03:53 PM, John Bradley wrote:
> Andrew Baumann has and others have release the code under GNU General Public License version 2 (GPLv2), the same as QEMU that allows me to added it to QEMU as it is under the same license, by signing it off this is what I am certifying. 

See this document linked from the SubmitAPatch link (it describes the
kernel meaning of S-o-b tags, although the qemu meaning is the same):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297

Yes, your Signed-off-by: asserts that you are okay releasing your
portions of the patch (bullets a, d) and that you chased down that
portions that you did not write are properly licensed (bullet b), but
what you are missing is that when you modify someone else's patch, we
also need that someone's assertion of intent that their work (whether or
not modified by you) meets the same standards (bullet c).  In other
words, when modifying a patch, S-o-b lines should be additive in nature,
rather than replacing his by yours (or, if his is missing in the source
you originally copied from, then we really need to Andrew to chime in
and add one); this is so that there is a full chain of custody on who
wrote portions of the commit.


>  John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge Hill Liverpool L7 7AF 

Your mailer is sending very poor formatting when rendered as plain text
(and we frown on html mail on this list).

> 
>     On Wednesday, 17 May 2017, 20:11, Eric Blake <eblake@redhat.com> wrote:
>  
> 
>  On 05/17/2017 01:34 PM, John Bradley wrote:
>> This is especial true as I meant Andrew Baumann 0xabu (Andrew Baumann)
> 
> Top-posting is not nice on technical lists.

And yet, in spite of me mentioning it, you still top-posted. :(


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org



Well unfortunately Eric. I don't understand your "top posted" slang.

As for 
his "intent", it is quite irrelevant as I have gone over the code line 
by line and what every he intended to do, he has succeed, as far as I 
can tell , in matching you standards, to such an extent that I am happy 
that he has succeeded in reaching your standards and am happy to certify that he has.

As for my mailer it is Yahoos and again as far as I can tell it is full RFC822 compliant, so perhaps you should adjust you obviously defective mail reader.
