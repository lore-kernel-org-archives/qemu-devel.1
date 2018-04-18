Received: from eggs.gnu.org ([2001:4830:134:3::10]:59459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1f8i9n-0004g1-As
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1f8i9m-0003qW-7y
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:09:35 -0400
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:40652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1f8i9m-0003qE-2o
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:09:34 -0400
Received: by mail-io0-x232.google.com with SMTP id t123-v6so1384213iof.7
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 01:09:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMxP3BThUkaPWRq=D2AhecGgpmC-F=_fGbBQX-oyaqMs95s3Pw@mail.gmail.com>
References: <CAMxP3BSFEuknshd05kSn8EjNuv8F8aPGuNFG3qUd0Ap6GbZFrQ@mail.gmail.com>
	<18e4de85-274e-54aa-e34e-4fd3f82e40e2@weilnetz.de>
	<CAMxP3BThUkaPWRq=D2AhecGgpmC-F=_fGbBQX-oyaqMs95s3Pw@mail.gmail.com>
From: Bob Chen <a175818323@gmail.com>
Date: Wed, 18 Apr 2018 16:09:32 +0800
Message-ID: <CAMxP3BRXh8MLz2KQ_bG-v0KzrL9CxG7bCbtsEfijJ2DUFAbjUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Latest v2.12.0-rc4 has compiling error, rc3 is OK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org

I found that it has nothing to do with the release version, but the github
one is just not able to work...

So what github and qemu.org provide are totally different things?




2018-04-18 14:52 GMT+08:00 Bob Chen <a175818323@gmail.com>:

> No, I downloaded the release tarball from github.
>
> 2018-04-18 14:25 GMT+08:00 Stefan Weil <sw@weilnetz.de>:
>
>> Am 18.04.2018 um 08:19 schrieb Bob Chen:
>> > fatal error: ui/input-keymap-atset1-to-qcode.c: No such file or
>> directory
>> >
>> > Build on my CentOS 7.
>> >
>>
>> That file is generated during the build. rc4 compiles in my test on
>> Debian. Did you start your build from a fresh git clone?
>>
>> Stefan
>>
>
>
