Received: from eggs.gnu.org ([2001:4830:134:3::10]:59819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZzI5-0004hI-9X
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZzI1-0007Z7-JQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:50:21 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZzI1-0007Yf-Cm
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:50:17 -0400
Received: by mail-wr0-x229.google.com with SMTP id v105so88358896wrb.0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 05:50:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724183517.GA2427@work-vm>
References: <1500309462-12792-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA9yup9CQzst6m14oO+7JHZ2F0mkrsnUN5LLx++=9ctqMw@mail.gmail.com>
	<20170724183517.GA2427@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2017 13:49:55 +0100
Message-ID: <CAFEAcA94ovPdsHdKGjSUpTYtN=rzFTxzrbJznQNyr93DmL6Apg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] hw/display/sm501: Don't use
 vmstate_register_ram_global()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 24 July 2017 at 19:35, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> Ping for review, please? Would be nice to get this into rc0.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks; applied to master.

-- PMM
