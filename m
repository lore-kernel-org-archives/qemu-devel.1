Received: from eggs.gnu.org ([2001:4830:134:3::10]:38714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cu1RH-0007gd-9c
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cu1RD-0005q2-98
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:38:23 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:54666
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cu1RD-0005pV-1X
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:38:19 -0400
References: <d4c50e61-112c-1818-479e-494d58e361f2@ilande.co.uk>
	<CAFEAcA_vArTuWDGpTeToFhjfSV1BC3BV8WhjDsZtO5uxWiarMQ@mail.gmail.com>
	<d8a1ecfb-cce1-e855-9f0b-49dccd830155@weilnetz.de>
	<9e2591a0-4c25-5f00-0fd3-9c175bfbab12@ilande.co.uk>
	<25632d57-622c-e0b0-029a-28fdca0a427f@weilnetz.de>
	<360a7047-6190-c006-e155-1166ab14b83a@ilande.co.uk>
	<e776dac5-ea72-efaf-c9d5-6b98f49e47e7@redhat.com>
	<fb90c304-7f13-083f-37d8-7e2b569b15fe@ilande.co.uk>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <a4957051-8f41-cdbf-b51a-9aa0bf5ff836@weilnetz.de>
Date: Fri, 31 Mar 2017 20:38:14 +0200
MIME-Version: 1.0
In-Reply-To: <fb90c304-7f13-083f-37d8-7e2b569b15fe@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Problems with native Mingw-w64 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

Am 31.03.2017 um 19:08 schrieb Mark Cave-Ayland:
> On 28/03/17 16:16, Thomas Huth wrote:
>> We've already got a page with instructions for building with MingW:
>>
>>  http://wiki.qemu-project.org/Hosts/W32
>>
>> So that might be a good place to add your experience with MSYS, I guess?
>
> Done. See
> http://wiki.qemu-project.org/Hosts/W32#Native_builds_with_MSYS2 for
> details of how to build on W64 with MSYS2.
>
>
> ATB,
>
> Mark.


Great, thank you. I added some notes on Intel HAXM, too.

Stefan
