Received: from eggs.gnu.org ([2001:4830:134:3::10]:54605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHoaF-0004as-CT
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHoa9-000761-KJ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:18:15 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:40618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHoa9-00074m-DU
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:18:09 -0500
Received: by mail-ot0-x22b.google.com with SMTP id g104so15945535otg.7
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 02:18:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171123110345.03541b50.cohuck@redhat.com>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 10:17:48 +0000
Message-ID: <CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU 3.0 ? (was: [PATCH for-2.12 v3 01/11] spapr:
 add pseries 2.12 machine type)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

On 23 November 2017 at 10:03, Cornelia Huck <cohuck@redhat.com> wrote:
> On Mon, 13 Nov 2017 08:14:28 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>
>> By the way, before everybody now introduces "2.12" machine types ... is
>> there already a consensus that the next version will be "2.12" ?
>>
>> A couple of months ago, we discussed that we could maybe do a 3.0 after
>> 2.11, e.g. here:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05056.html
>>
>> I'd still like to see that happen... Peter, any thoughts on this?
>
> So, as I just thought about preparing the new machine for s390x as
> well: Did we reach any consensus about what the next qemu version will
> be called?

I haven't seen any sufficiently solid plan to make me want to
pick anything except "2.12".

thanks
-- PMM
