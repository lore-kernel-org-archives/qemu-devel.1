Received: from eggs.gnu.org ([2001:4830:134:3::10]:52769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d19ya-0005e0-Bz
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 07:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d19yV-0004lc-CS
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 07:10:16 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d19yV-0004kK-8f
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 07:10:11 -0400
Received: by mail-qt0-x241.google.com with SMTP id y33so6957733qta.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 04:10:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
	<CAFEAcA_YVJKobjJ2WeEquxUdXVYeaCvA-K0+zumCc-Rm4Tk5nQ@mail.gmail.com>
	<20170403141912.GA3539@stefanha-x1.localdomain>
	<87fuhf9kcz.fsf@dusky.pond.sub.org>
	<20170418095103.GF21261@stefanha-x1.localdomain>
	<1492516675.27392.45.camel@redhat.com>
	<7ae1e13f-b6a0-a735-3952-4e3833e34ad8@redhat.com>
	<1492596922.6853.5.camel@redhat.com>
	<dbaad765-44b8-785f-3612-3173001b94bf@redhat.com>
	<1492666811.6853.42.camel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e0dadbc0-28c3-9b69-80a3-bfec0a77c419@amsat.org>
Date: Thu, 20 Apr 2017 08:10:06 -0300
MIME-Version: 1.0
In-Reply-To: <1492666811.6853.42.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

>>> You can have two floppy drives, but they are hooked to the same
>>
>> Yes, I'm aware.
>>
>> I'm just saying here "Spec-wise" because you can have two controllers,
>> one at 0x3F0 and one at 0x370.
>
> Oh, ok.  Wasn't aware of this detail.
>
> Can't remember to have ever seen a pc with more than two floppy drives
> (as-in: physical hardware).  And even two floppy drives is pretty rare.
> Only in the early 90ies, while the transition from 5.25" floppies to
> 3.5" floppies happened, it was somewhat common to have two drives (one
> of each type).

Preteens multitasking... Copying W4r3z while surfing on FidoNet and 
running PCBoard on your 1040ST before catching school bus.

Remembering BBS life at 2400bps?
                     __
                    /  \
                   /|oo \
                  (_|  /_)
                   _`@/_ \    _
                  |     | \   \\
                  | (*) |  \   ))
     ______       |__U__| /  \//
    / FIDO \       _//|| _\   /
   (________)     (_/(_|(____/
  (c) John Madil
