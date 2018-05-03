Received: from eggs.gnu.org ([2001:4830:134:3::10]:57337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEAW3-0007OD-IX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEAVy-0008AV-2B
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:27:07 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:35821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEAVx-0008AK-Tl
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:27:01 -0400
Received: by mail-ot0-x235.google.com with SMTP id h8-v6so19849614otb.2
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:27:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180503090727.GC11382@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 10:26:40 +0100
Message-ID: <CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 3 May 2018 at 10:07, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote=
:
> On Thu, May 03, 2018 at 08:21:00AM +0100, Stefan Hajnoczi wrote:
>> I don't see an issue with time-based numbering schemes.  Ubuntu made it
>> popular and other projects (like DPDK) are doing the same thing now.
>>
>> The convention is YY.MM though, not YYMM.
>
> It feels like we've got quite a strong backing for time based versioning
> amongst people replying here. I'd be happy with YY.MM

I'm not hugely in favour mostly because I don't much like
changing version numbering formats -- does it really gain
us anything? But I guess it's a bit of a bikeshed-colour question.

thanks
-- PMM
