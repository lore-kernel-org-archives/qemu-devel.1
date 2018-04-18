Received: from eggs.gnu.org ([2001:4830:134:3::10]:33787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f8k10-0004zF-NV
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f8k0w-000764-NX
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:08:38 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:43360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f8k0w-00075m-Gg
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:08:34 -0400
Received: by mail-wr0-x236.google.com with SMTP id u4-v6so3185795wrg.10
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 03:08:34 -0700 (PDT)
References: <CAMxP3BSFEuknshd05kSn8EjNuv8F8aPGuNFG3qUd0Ap6GbZFrQ@mail.gmail.com>
	<18e4de85-274e-54aa-e34e-4fd3f82e40e2@weilnetz.de>
	<CAMxP3BThUkaPWRq=D2AhecGgpmC-F=_fGbBQX-oyaqMs95s3Pw@mail.gmail.com>
	<CAMxP3BRXh8MLz2KQ_bG-v0KzrL9CxG7bCbtsEfijJ2DUFAbjUA@mail.gmail.com>
	<CAFEAcA-sGiZFdAa8Gnfbo_=o-ZZbChyDJAV9oGmMTBC8BNS3sQ@mail.gmail.com>
	<CAMxP3BR8PLzKacyty+xLJyMf2wjFdQUgutQ+MJpnWH0_4PpfZA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAMxP3BR8PLzKacyty+xLJyMf2wjFdQUgutQ+MJpnWH0_4PpfZA@mail.gmail.com>
Date: Wed, 18 Apr 2018 11:08:32 +0100
Message-ID: <87wox4aktb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Latest v2.12.0-rc4 has compiling error, rc3 is OK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>


Bob Chen <a175818323@gmail.com> writes:

> I think you can edit the github's repo description to tell people not to
> download release from this site.

I've updated the repo description.

  Official QEMU mirror. Please see
  http://wiki.qemu.org/Contribute/SubmitAPatch for how to submit changes
  to QEMU. Pull Requests are ignored. Please only use release tarballs
  from the QEMU website. http://www.qemu.org


>
> 2018-04-18 17:29 GMT+08:00 Peter Maydell <peter.maydell@linaro.org>:
>
>> On 18 April 2018 at 09:09, Bob Chen <a175818323@gmail.com> wrote:
>> > I found that it has nothing to do with the release version, but the
>> github
>> > one is just not able to work...
>> >
>> > So what github and qemu.org provide are totally different things?
>>
>> The "tarballs" from github don't work and can't work, but
>> github provides no mechanism for the project to say "don't
>> create this page". You can complain to github about this
>> if you like.
>>
>> You're best off starting with the project's own web
>> page: https://www.qemu.org/ -- we use github only as
>> a sort of backup git server in case our own is down.
>>
>> thanks
>> -- PMM
>>


--
Alex Benn=C3=A9e
