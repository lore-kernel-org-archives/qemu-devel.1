Received: from eggs.gnu.org ([2001:4830:134:3::10]:35332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW4Se-0000yY-83
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW4SX-0000xe-U1
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:00:48 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW4SX-0000x0-JZ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:00:41 -0500
Received: by mail-wm0-x229.google.com with SMTP id c206so219696478wme.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:00:41 -0800 (PST)
References: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 17:00:38 +0000
Message-ID: <87o9yw9yvd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] ARMv7M: some simple
 bugfixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> This set of six patches is some simple bug fixes which
> I've pulled out of Michael Davidsaver's old NVIC rewrite
> patchset, as an initial start on getting it upstream.
> None of them are particularly exciting, but they're
> self-contained so they might as well go through code
> review and get into master ahead of the main rewrite.

I've completed my pass through - it all looks pretty good to me
(squashed tab stops on the commit messages not-withstanding ;-)

--
Alex Bennée
