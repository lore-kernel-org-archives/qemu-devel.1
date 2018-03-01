Received: from eggs.gnu.org ([2001:4830:134:3::10]:39551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erMds-0004nr-RE
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erMds-00024Z-4H
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:44:56 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:39195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erMdr-00023c-Um
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:44:56 -0500
Received: by mail-ot0-x232.google.com with SMTP id h8so5275075oti.6
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 03:44:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-D=f-kAKMB+cj91ffUW2MD0wDQt0XA_3gVec=YDBfkg@mail.gmail.com>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
	<CAFEAcA8-D=f-kAKMB+cj91ffUW2MD0wDQt0XA_3gVec=YDBfkg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 11:44:34 +0000
Message-ID: <CAFEAcA_4jEgbJfk7HzeaYoFm53FopV=8RO9K=uY0H8L74-zrJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH REPOST v1 0/8] Group support and random
 clean-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 23 February 2018 at 18:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> I've pushed all but 3 and 5 to risu master. I don't actually
> object to patch 5 and will probably push that too, but I figure we
> could have the conversation first :-)

I added the missing patterns and pushed patch 3 and have
(per irc conversation) dropped 5.

-- PMM
