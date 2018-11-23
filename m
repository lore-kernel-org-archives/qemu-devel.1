Received: from eggs.gnu.org ([2001:4830:134:3::10]:54621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQ7SX-0004Uo-Ek
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQ7SV-0001Rg-Qe
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:09:09 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gQ7SV-0001Pz-Cn
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:09:07 -0500
Received: by mail-ot1-x343.google.com with SMTP id 81so10102574otj.2
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 01:09:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <43381cce-1af0-8613-edf3-c216afdbe142@redhat.com>
References: <20181122180143.14237-1-eric.auger@redhat.com>
	<1259e457-6cb8-3b1e-853f-53f1e47cac63@redhat.com>
	<43381cce-1af0-8613-edf3-c216afdbe142@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Nov 2018 09:08:45 +0000
Message-ID: <CAFEAcA_s50WTbdJ9QWPjmXw0Xo=RpkAFPQJjzwSc3pQXL5neaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] MAINTAINERS: Add an ARM SMMU
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Thomas Huth <thuth@redhat.com>

On 23 November 2018 at 08:04, Auger Eric <eric.auger@redhat.com> wrote:
> On 11/22/18 11:33 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 22/11/18 19:01, Eric Auger wrote:
>>> +ARM SMMU
>>> +M: Eric Auger <eric.auger@redhat.com>
>>> +L: qemu-arm@nongnu.org
>>> +S: Maintained
>>
>> Shouldn't you use 'Supported': "Someone is actually paid to look after
>> this."?
> Not sure this is really important as long as get_maintainer.pl returns
> the right contacts. Many ARM sections do not feature the "Supported"
> tag. I will follow Peter's guidance though.

I don't really understand the purpose of the Supported vs
Maintained distinction. Mostly I list stuff as just
Maintained when I am dealing with it.

I think in particular that if a part of QEMU is just one
of a whole set of things that you are doing as part of
your job then Supported is a bit overstating things.

thanks
-- PMM
