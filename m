Received: from eggs.gnu.org ([2001:4830:134:3::10]:50317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWLe5-0004SE-Vj
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWLe5-00066z-9q
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:58:34 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWLe5-00066g-3H
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:58:33 -0400
Received: by mail-oi0-x242.google.com with SMTP id k190-v6so6019876oib.9
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 05:58:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-xe-zX8_y3p_XKb2pHharJwwfL3ebtUU71E_EY+xvU3w@mail.gmail.com>
References: <20180426140253.3918-1-peter.maydell@linaro.org>
	<4f0eec20-64a6-fb8f-58ae-1fab9ef34f53@redhat.com>
	<CAFEAcA86RRfz-YQivsPDRqAbZqOtdNpRnnBeKC24B5yYzY1=zg@mail.gmail.com>
	<CAFEAcA-xe-zX8_y3p_XKb2pHharJwwfL3ebtUU71E_EY+xvU3w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:58:12 +0100
Message-ID: <CAFEAcA-+vOgGj_Mbow2H4c1NNdjSNXibMqSmFF8KibKBbDeRsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vl.c: Don't zero-initialize statics for
 serial_hds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 11 June 2018 at 14:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> Ping^2 for qemu-trivial?

Gave up and threw it into the latest target-arm pullreq :-)

thanks
-- PMM
