Received: from eggs.gnu.org ([2001:4830:134:3::10]:50842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e9ufw-00085O-Ny
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e9ufr-0003Yg-Q0
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:11:28 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:56272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1e9ufr-0003Xw-KO
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:11:23 -0400
Received: by mail-io0-x242.google.com with SMTP id p186so6683460ioe.12
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 08:11:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA-Ts6a5V+w9KRaB8U6Wz_ZoHGp+Wac=2sY=dpzoe_rOsg@mail.gmail.com>
Date: Wed, 1 Nov 2017 11:11:20 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <74DB5D41-EFA5-41FD-A8E3-4621F8965B95@gmail.com>
References: <20171005145557.5746-1-programmingkidx@gmail.com>
	<20171005145557.5746-3-programmingkidx@gmail.com>
	<CAFEAcA_dhMWxRpz8hZ-Ljw+dwWha_NCUZQiaq96V=b0LNvqq2g@mail.gmail.com>
	<CAFEAcA-Ts6a5V+w9KRaB8U6Wz_ZoHGp+Wac=2sY=dpzoe_rOsg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ui/cocoa.m: send ctrl-alt key
 combinations to guest if not used by QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


> On Oct 31, 2017, at 10:52 AM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On 31 October 2017 at 14:38, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>> On 5 October 2017 at 15:55, John Arbuckle <programmingkidx@gmail.com> =
wrote:
>>> Send control-alt key combinations to the guest if not used by the =
user interface.
>>>=20
>>> ---
>>> v2 changes:
>>> - changed logic to use existing if case
>>>=20
>>=20
>> This patch is missing your signed-off-by line, can you provide
>> it, please?
>=20
> ...actually, don't worry -- I wrote an equivalent of this patch
> that does the same thing but doesn't need to get rid of the
> switch() statement.
>=20
> thanks
> -- PMM

Please cc me when you send it to the mailing list. Thanks.=
