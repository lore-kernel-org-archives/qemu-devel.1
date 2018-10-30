Received: from eggs.gnu.org ([2001:4830:134:3::10]:51927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHVXv-0001rx-16
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHVXq-0001fP-Es
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:03:06 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:35962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHVXp-0001cy-VR
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:03:02 -0400
Received: by mail-ot1-x32c.google.com with SMTP id x4so11389280otg.3
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 08:03:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB125136875C6C4CCFC2B2DF62C6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB1251EA1F1F5E486A889A827CC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<e1aa7445-8eb5-f63c-ad85-7ad9c25d8ac5@redhat.com>
	<BN6PR2201MB125136875C6C4CCFC2B2DF62C6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 15:02:40 +0000
Message-ID: <CAFEAcA9bLwe_pmNRBCwPNOeDLFdVcPgvFysg0kxodFg+aj9M1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Question: Perfecting checkpatch.pl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>

On 30 October 2018 at 14:48, Aleksandar Markovic <amarkovic@wavecomp.com> wrote:
>
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Sure, both are good ideas.  Can you write a patch for it?
>
> I would rather not, I prefer to see it as a black box.

So do most of the rest of us :-)  This is why sometimes
it does not have all the features that might seem nice for
it to have...

thanks
-- PMM
