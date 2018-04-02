Received: from eggs.gnu.org ([2001:4830:134:3::10]:50643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1f383G-0003gp-Qy
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 18:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1f383D-0005RF-NH
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 18:35:46 -0400
Received: from mail-it0-x236.google.com ([2607:f8b0:4001:c0b::236]:55391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1f383D-0005OF-Ic
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 18:35:43 -0400
Received: by mail-it0-x236.google.com with SMTP id 142-v6so20716721itl.5
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 15:35:43 -0700 (PDT)
References: <20180320090813.852-1-laurent@vivier.eu>
	<d409453e-21c4-c989-c40c-442dcb8f2636@landley.net>
	<7cac14a3-c097-572e-4b61-8960209f6bd9@vivier.eu>
	<67f4fb22-9ad5-7f41-371a-001d1346fc4f@landley.net>
	<e95756ac-f3e8-dc5c-31db-c88fbb37756d@vivier.eu>
From: Rob Landley <rob@landley.net>
Message-ID: <2b88e5c6-41a9-5aff-6fe2-f29c0e403d17@landley.net>
Date: Mon, 2 Apr 2018 17:35:40 -0500
MIME-Version: 1.0
In-Reply-To: <e95756ac-f3e8-dc5c-31db-c88fbb37756d@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/2] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Finn Thain <fthain@telegraphics.com.au>

On 04/02/2018 02:05 PM, Laurent Vivier wrote:
> Le 02/04/2018 à 20:13, Rob Landley a écrit :
>>> The branch to use is q800-dev
...
>> It booted Linux to a shell prompt, I could wget a file from the internet, and
>> /home had the 2 gigabyte ext3 mount from the virtual block device.
>>
>> I.E. it works for me. Why is it still out of tree?
...
> I have to submit some enhancements in the FPU emulation...
> I have to add some specific m68k hardware emulation...
> but via support should be rewritten...
> I have to update some existing hardware emulation...
...
> So, this only needs some work and time.
10 years ago:

https://lists.gnu.org/archive/html/qemu-devel/2007-10/msg00248.html

6 years ago:

https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02123.html

> I hope q800 will be available in QEMU 2.13.

Good luck,

Rob
