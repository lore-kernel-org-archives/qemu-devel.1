Received: from eggs.gnu.org ([2001:4830:134:3::10]:33317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJzlM-0003fC-Sg
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJzlL-0002Vt-2g
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:43:15 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJzlK-0002UG-Ga
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:43:15 -0500
Received: by mail-oi1-x242.google.com with SMTP id u130-v6so10412631oie.7
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 03:43:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1aee9b00-dd53-4e10-e56d-dc0c5628edec@comstyle.com>
References: <20181019125239.GA13884@humpty.home.comstyle.com>
	<1aee9b00-dd53-4e10-e56d-dc0c5628edec@comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 11:42:53 +0000
Message-ID: <CAFEAcA-zFw4h7cd9BSd_mZ0Kp8RStJy0ZbNAOv2MmRxUuMB6=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 November 2018 at 22:44, Brad Smith <brad@comstyle.com> wrote:
> ping.
>

Thanks for the ping, applied to master for rc0.

-- PMM
