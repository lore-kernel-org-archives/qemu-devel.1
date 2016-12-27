Received: from eggs.gnu.org ([2001:4830:134:3::10]:60965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLvUc-0002uW-Ap
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLvUb-0001uD-5R
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:24:54 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:35675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cLvUa-0001u3-NA
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:24:52 -0500
Received: by mail-vk0-x22c.google.com with SMTP id y197so63497398vky.2
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 09:24:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1958441218.7403706.1482859145031.JavaMail.zimbra@redhat.com>
References: <5a3cff0afa557527bb1ab6692d4e096c@rc.la-evento.com>
	<1958441218.7403706.1482859145031.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 17:24:31 +0000
Message-ID: <CAFEAcA-x-2yMFhHP+x-hGjvJtcYEjsMG3DxvypBxm08CFBGkKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu: bunch of spelling-fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <mlureau@redhat.com>
Cc: ka7@la-evento.com, QEMU Developers <qemu-devel@nongnu.org>

On 27 December 2016 at 17:19, Marc-Andr=C3=A9 Lureau <mlureau@redhat.com> w=
rote:
> Hi,
>
> ----- Original Message -----
>> phew. sounds too complicated.. sitting on wrong machine, wrong email
>> addresses and want to keep my personal footprint out there as small as
>> possible.
>> And hey, this are just typo-fixes, no rocket-science. It was even easier
>> to get the fixes into openssl
>>
>> But throwing the stuff as its done not into /dev/null is also not good.
>> So i picked someone at random from the trivial-mailinglist... tada...
>>
>
> If you don't have the time to follow
> http://qemu-project.org/Contribute/SubmitAPatch, perhaps someone
> else will do it for you, or not.

An important part of the instructions is the part where you
have to provide your Signed-off-by: line with your name and
email address. This says "I own the copyright on these changes
and am happy for them to go into QEMU under the QEMU license".
Without that signoff we unfortunately can't accept the changes,
even if somebody else does the work of cleaning them up, reviewing
them and applying them :-(

thanks
-- PMM
