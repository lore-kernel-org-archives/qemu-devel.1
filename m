Received: from eggs.gnu.org ([2001:4830:134:3::10]:47798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eXBZE-0002lJ-N5
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eXBZB-0000Gh-GI
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:52:44 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eXBZB-0000FR-7E
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:52:41 -0500
References: <mailman.16196.1515084191.27993.qemu-devel@nongnu.org>
	<AE31CFE4-27FD-40F8-81E3-0D7A8A9DE36E@gmail.com>
	<bee022ee-30de-586a-d892-68291159de77@vivier.eu>
	<6975EB15-A268-4332-AA38-B31BFA22F4E8@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f555034b-6952-0261-04d6-8707f7c11969@vivier.eu>
Date: Thu, 4 Jan 2018 20:52:38 +0100
MIME-Version: 1.0
In-Reply-To: <6975EB15-A268-4332-AA38-B31BFA22F4E8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/17] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Le 04/01/2018 à 20:26, Programmingkid a écrit :
> 
>> On Jan 4, 2018, at 12:32 PM, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 04/01/2018 à 18:09, Programmingkid a écrit :
>>> What operating systems boot with this patch set? Does any version of the Mac OS run in this 68k emulator? 
>>>
>>
>> For the moment you can't boot anything more than the coldfire linux
>> kernel with the semi-hosting patch.
>>
>> The remaining patches I have in my git branch allows to boot a debian
>> etch-m68k with GNOME or a the latest debian unstable (without GNOME)
>>
>> git clone -b q800-dev https://github.com/vivier/qemu-m68k.git
>>
>> I'm working on booting MacOS...
>>
>> I think we should also be able to boot NeXTSTEP , but the work of Bryce
>> Lanham (GSoC 2011) must be rebased on my branch and cleaned up.
> 
> If you have any pictures of guests running in QEMU I would be interested in posting the pictures on the wiki page here: https://wiki.qemu.org/Documentation/Platforms/68k.
> 

Can you add a video instead?

https://www.youtube.com/watch?v=wKpzBwsLmhw

Laurent
