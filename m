Received: from eggs.gnu.org ([2001:4830:134:3::10]:50911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ee35Y-0007l8-Gc
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ee35X-00082z-KV
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:14:28 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ee35X-00082e-Ef
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:14:27 -0500
Received: by mail-ot0-x244.google.com with SMTP id d7so1252838oti.0
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 10:14:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADYoBw36gPOyiK36WaS0v_2R=iuWYL-sQAtffrZZJU2DpMv5Bw@mail.gmail.com>
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
	<CAFEAcA--i8RVKaBw5yXn4xRXBy5S+Yk=WDNKbuqzfDxn6jjtOA@mail.gmail.com>
	<CADYoBw36gPOyiK36WaS0v_2R=iuWYL-sQAtffrZZJU2DpMv5Bw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2018 18:14:06 +0000
Message-ID: <CAFEAcA-1xLL1e=tyLg0d3V_PJBKjwEWNxnajTd-8trbGaR=4iw@mail.gmail.com>
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
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On 23 January 2018 at 11:49, bzt bzt <bztemail@gmail.com> wrote:
> Hi,
>
> On Mon, Jan 22, 2018 at 1:12 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>> Can you send this as a proper patch email, not as a reply to
>> an existing email thread, please? (This makes our automated tooling
>> much happier.)
>
>
> Only if you're not demanding any further nonsense modifications.

I think that patch review will be much more pleasant for
both of us if you tone down the combativeness here.
Yes, sometimes code review comments aren't right because
the reviewer has missed or misunderstood a detail -- but
there's no need to throw insults around as a result.

If you don't have the time or don't want to engage with the
community's review processes, that's fine. But this hostility
is not pleasant to interact with and off-putting to other
people reading it. Please stop it.

(Sometimes a submitter doesn't have the time to work with our
review process, and that's fine. It just means that the patches
will sit on the mailing list and perhaps in future somebody
who does have the time as well as the interest in the feature
will come along and pick up the work.)

thanks
-- PMM
