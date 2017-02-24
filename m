Received: from eggs.gnu.org ([2001:4830:134:3::10]:59500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chCsr-00024G-5N
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:13:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chCsq-0000DG-AG
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:13:53 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chCsq-0000Bx-2e
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:13:52 -0500
Received: by mail-wr0-x235.google.com with SMTP id u47so9960207wrb.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 02:13:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a2a90a25-7a90-1db2-ee77-c20f31cda6d5@imgtec.com>
References: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
	<1487722868-9111-9-git-send-email-yongbok.kim@imgtec.com>
	<CAFEAcA_314UcvxXFPw7XkXnEqDCRWEvPdPRLgGKZJTU+-eg+9g@mail.gmail.com>
	<a2a90a25-7a90-1db2-ee77-c20f31cda6d5@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 10:13:30 +0000
Message-ID: <CAFEAcA-v-O0y1X4Vwx1GyZiCQ=92bHB-kAQt7LTftokz-Qu0MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 8/8] hw/mips: MIPS Boston board support
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

On 24 February 2017 at 00:25, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> My apologies for the inconvenience! I missed to check it on the 32-bit hosts.
>
> I am not seeing the revert commit on the master?

It didn't finish testing before I went home yesterday. I've
just pushed it out now.

thanks
-- PMM
