Received: from eggs.gnu.org ([2001:4830:134:3::10]:49027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edwet-0000r5-Ag
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edwes-00006j-G9
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:22:31 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edwes-000065-Bt
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:22:30 -0500
Received: by mail-oi0-x241.google.com with SMTP id k15so91511oib.1
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 03:22:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADYoBw3qjq_CJpp3dQvpHvAgfx-FjhPvPgZ4xTpSBt4LEGiiOw@mail.gmail.com>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
	<MWHPR21MB01591543E188B048145985709E470@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw0RjiW2as9jGtPg92E8XK3KR+gM9C5vjC7HHsBauFn4ug@mail.gmail.com>
	<CADYoBw19GifmUR=Rztkzzc-v3-zWR6frjiNb_wjzsevreAqPDQ@mail.gmail.com>
	<CAFEAcA9_+wZJa7Ht6EHCCZYm+hrfdbjd9gUmVJPGgZ0yvbZOPA@mail.gmail.com>
	<MWHPR21MB0480DE1F826056BC8377EE289E250@MWHPR21MB0480.namprd21.prod.outlook.com>
	<CADYoBw31C0Z2vp0S0ZFBOC6A3146wxtZWvzJabACkGh44ZwC0w@mail.gmail.com>
	<MWHPR21MB0480A1F01D2CEF51E7CE21B09E3A0@MWHPR21MB0480.namprd21.prod.outlook.com>
	<CADYoBw1Ro5gxROvhCVXGv0=-Y8zXmGbKR3D6xOqhkb0zp__LkA@mail.gmail.com>
	<CADYoBw27wU3CsYPeP7ONFWt4aj+6tvzwU5roDSOKz8qq1n8GSg@mail.gmail.com>
	<alpine.BSF.2.21.1801221224400.67089@zero.eik.bme.hu>
	<CADYoBw3qjq_CJpp3dQvpHvAgfx-FjhPvPgZ4xTpSBt4LEGiiOw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2018 11:22:09 +0000
Message-ID: <CAFEAcA-uedKpcQGXb1UY_orGpD65Xra3aBpUpwb2RxFo3hB4Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] BCM2837 and machine raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bzt bzt <bztemail@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 23 January 2018 at 11:13, bzt bzt <bztemail@gmail.com> wrote:
> There's a huge misunderstanding here. I have a working qemu for about half a
> year now, and I don't need it merged. It's not my goal to submit a patch to
> qemu in any way, I just did that because I had modified an Open Source
> software and wanted to share it with the community. If you don't merge my
> patch, I don't care. Other users will.

Unfortunately we legally can't merge your patch (even if somebody
else is willing to do the work of cleaning it up) because you
haven't provided a signed-off-by line...

thanks
-- PMM
