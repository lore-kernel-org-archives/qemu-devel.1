Received: from eggs.gnu.org ([2001:4830:134:3::10]:36785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3laB-0006VD-8U
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3laA-0007oJ-Gv
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:48:23 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:39161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3laA-0007ny-Bd
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:48:22 -0400
Received: by mail-oi0-x235.google.com with SMTP id q71-v6so19853482oic.6
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 09:48:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5398bc08-58ad-32ac-8125-e079441216e7@redhat.com>
References: <20180328133152.24623-1-lvivier@redhat.com>
	<cb19950a-9b8e-90be-49df-b145900e2958@redhat.com>
	<5398bc08-58ad-32ac-8125-e079441216e7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 17:48:00 +0100
Message-ID: <CAFEAcA_91+QLBLWtfRkrJ5aVBHCRpO8BMBaxGUuRSAk1nFnrFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: fix 16-byte vector operations
 detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Miroslav Rezanina <mrezanin@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 3 April 2018 at 16:45, Laurent Vivier <lvivier@redhat.com> wrote:
> On 29/03/2018 18:54, Laurent Vivier wrote:
>> Hi,
>>
>> I think it would be good to have this fix (or something similar) in -rc2.
>
> So no one agrees with that?

Applied to master, thanks.

-- PMM
