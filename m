Received: from eggs.gnu.org ([2001:4830:134:3::10]:41428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coYHB-00061z-PK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coYHB-0002UA-5g
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:29:21 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coYHA-0002Tz-VQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:29:21 -0400
Received: by mail-wm0-x232.google.com with SMTP id u132so39684158wmg.0
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:29:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <efc923c7-ae6b-a159-b9b8-a35b845f39d5@imgtec.com>
References: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
	<CAFEAcA_G=KNQSitea9sE1pfDDZA7tR9zqFKbm-0KASaT6v6kag@mail.gmail.com>
	<CAFEAcA_NEg7cCQvut7eBTp=mBMdM_7q9mB2K=mH6SmC9ODodQg@mail.gmail.com>
	<efc923c7-ae6b-a159-b9b8-a35b845f39d5@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 16:28:59 +0000
Message-ID: <CAFEAcA9u4n_d1o9O1kMNPXorAP=jrQZtaW4+2sx7Kev9=9QRQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 0/8] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 March 2017 at 16:25, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> I updated the section before?
>
> Build dependencies
>
>     QEMU now requires a minimum dtc version of 1.4.2.
>
> Do you mean to update it like "dtc (libfdt)"?
>

No, that's fine. Sorry, I must have somehow been looking at
a stale version of the page or the wrong copy or something.

thanks
-- PMM
